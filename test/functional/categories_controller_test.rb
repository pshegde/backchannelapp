require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = Category.find_all_by_name("MyString").first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, :category => { name: "newestcategory" }
    end
    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, id: @category.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category.id
    assert_response :success
  end

  test "should update category" do
    put :update, id: @category.id, category: { name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category.id
    end

    assert_redirected_to categories_path
  end
end
