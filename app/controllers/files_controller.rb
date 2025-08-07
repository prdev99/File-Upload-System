class FilesController < ApplicationController
  def shared
    @file_upload = FileUpload.find_by(token: params[:token])

    if @file_upload&.file&.attached?
      redirect_to rails_blob_url(@file_upload.file, disposition: "attachment")
    else
      render plain: "Invalid or expired link", status: :not_found
    end
  end

  def show
    @file = FileUpload.find_by!(token: params[:token])
    file_to_download = @file.compressed_file.attached? ? @file.compressed_file : @file.file

    redirect_to rails_blob_url(file_to_download, disposition: "attachment")
    end
end
