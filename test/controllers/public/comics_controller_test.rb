require "test_helper"

class Public::ComicsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_comics_show_url
    assert_response :success
  end

  test "should get index" do
    get public_comics_index_url
    assert_response :success
  end

  test "should get edit" do
    get public_comics_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_comics_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_comics_destroy_url
    assert_response :success
  end
end
