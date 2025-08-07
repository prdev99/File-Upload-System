class FileUpload < ApplicationRecord
  require 'zip'

  belongs_to :user
  has_one_attached :file
  has_one_attached :compressed_file

  validates :title, presence: true
  validates :file, attached: true,
                   content_type: ['application/pdf', 'image/png', 'image/jpeg', 'video/mp4'],
                   size: { less_than: 1.gigabyte }

  before_create :generate_token
  after_commit :compress_uploaded_file, on: :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(10)
  end

  def compress_uploaded_file
    return unless file.attached?

    zip_filename = "#{file.filename.base}.zip"
    temp_zip = Tempfile.new(zip_filename)

    begin
      Zip::OutputStream.open(temp_zip.path) do |zos|
        zos.put_next_entry(file.filename.to_s)
        zos.write(file.download)
      end

      compressed_file.attach(
        io: File.open(temp_zip.path),
        filename: zip_filename,
        content_type: 'application/zip'
      )
    ensure
      temp_zip.close
      temp_zip.unlink
    end
  end
end
