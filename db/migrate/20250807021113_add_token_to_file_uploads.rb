class AddTokenToFileUploads < ActiveRecord::Migration[7.1]
  def change
    add_column :file_uploads, :token, :string
    add_index :file_uploads, :token, unique: true
  end
end
