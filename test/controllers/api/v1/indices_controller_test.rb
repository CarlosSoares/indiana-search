require 'test_helper'

class Api::V1::IndicesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index, table_name: "clients"
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_v1_index" do
    assert_redirected_to api_v1_index_path(assigns(:api_v1_index))
  end

  test "should show api_v1_index" do
    get :show, id: @api_v1_index
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_v1_index
    assert_response :success
  end

  test "should update api_v1_index" do
    patch :update, id: @api_v1_index, api_v1_index: {  }
    assert_redirected_to api_v1_index_path(assigns(:api_v1_index))
  end

  test "should destroy api_v1_index" do
    assert_redirected_to api_v1_indices_path
  end
end
