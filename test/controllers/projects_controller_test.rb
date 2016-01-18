require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    sign_in :user, user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post :create, project: { name: Faker::Name.name }
    end

    assert_redirected_to projects_path
  end

  test "should show project" do
    get :show, id: @project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @project
    assert_response :success
  end

  test "should update project" do
    patch :update, id: @project, project: { name: Faker::Name.name }
    assert_redirected_to projects_path
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
