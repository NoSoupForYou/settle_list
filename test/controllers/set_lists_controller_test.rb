require 'test_helper'

class SetListsControllerTest < ActionController::TestCase
  setup do
    @set_list = set_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:set_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create set_list" do
    assert_difference('SetList.count') do
      post :create, set_list: { artist_id: @set_list.artist_id, description: @set_list.description, name: @set_list.name }
    end

    assert_redirected_to set_list_path(assigns(:set_list))
  end

  test "should show set_list" do
    get :show, id: @set_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @set_list
    assert_response :success
  end

  test "should update set_list" do
    patch :update, id: @set_list, set_list: { artist_id: @set_list.artist_id, description: @set_list.description, name: @set_list.name }
    assert_redirected_to set_list_path(assigns(:set_list))
  end

  test "should destroy set_list" do
    assert_difference('SetList.count', -1) do
      delete :destroy, id: @set_list
    end

    assert_redirected_to set_lists_path
  end
end
