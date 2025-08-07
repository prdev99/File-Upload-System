class FileUploadsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_file_upload, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:shared]

  def index
    @file_uploads = current_user.file_uploads.order(created_at: :desc)
  end

  def new
    @file_upload = current_user.file_uploads.build
  end

  def create
    @file_upload = current_user.file_uploads.build(file_upload_params)
    if @file_upload.save
      redirect_to file_uploads_path, notice: "File uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def shared
    @file_upload = FileUpload.find_by(token: params[:token])

    if @file_upload&.file&.attached?
      render :shared
    else
      redirect_to root_path, alert: "Invalid or expired link."
    end
  end

  def show; end
  def edit; end

  def update
    if @file_upload.update(file_upload_params)
      redirect_to @file_upload, notice: "File updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @file_upload.destroy
    redirect_to file_uploads_path, notice: "File deleted successfully."
  end

  private

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:id])
  end

  def file_upload_params
    params.require(:file_upload).permit(:title, :description, :file)
  end
end
