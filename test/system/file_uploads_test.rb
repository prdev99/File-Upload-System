require "application_system_test_case"

class FileUploadsTest < ApplicationSystemTestCase
  setup do
    @file_upload = file_uploads(:one)
  end

  test "visiting the index" do
    visit file_uploads_url
    assert_selector "h1", text: "File uploads"
  end

  test "should create file upload" do
    visit file_uploads_url
    click_on "New file upload"

    fill_in "Description", with: @file_upload.description
    fill_in "Title", with: @file_upload.title
    fill_in "User", with: @file_upload.user_id
    click_on "Create File upload"

    assert_text "File upload was successfully created"
    click_on "Back"
  end

  test "should update File upload" do
    visit file_upload_url(@file_upload)
    click_on "Edit this file upload", match: :first

    fill_in "Description", with: @file_upload.description
    fill_in "Title", with: @file_upload.title
    fill_in "User", with: @file_upload.user_id
    click_on "Update File upload"

    assert_text "File upload was successfully updated"
    click_on "Back"
  end

  test "should destroy File upload" do
    visit file_upload_url(@file_upload)
    click_on "Destroy this file upload", match: :first

    assert_text "File upload was successfully destroyed"
  end
end
