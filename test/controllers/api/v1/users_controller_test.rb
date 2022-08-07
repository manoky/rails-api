require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    # Test to ensure response contains the correct email
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end

  test "should create a new user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: {user: {email: 'test@tested.com', password: "thisisit123"}}, as: :json
    end
    assert_response :created
  end

  test "should not create a user if email exist" do
    assert_no_difference("User.count") do
      post api_v1_users_url, params: {user: {email:@user.email, password: 'test122345'}}, as: :json
    end
    assert_response :unprocessable_entity
  end

  test "should update user" do
    patch api_v1_user_url(@user), params: {user: {email: @user.email, password: 'new1234567'}}, as: :json
    assert_response :success
  end


   test "should not update user with invalid data" do
       patch api_v1_user_url(@user), params: {user: {email: "email", password: 'new1234567'}}, as: :json
       assert_response :unprocessable_entity
  end

  # DELETE users/1
  test "should delete user" do
    assert_difference("User.count", -1) do
      delete api_v1_user_url(@user), as: :json
    end

    assert_response :no_content
  end
end
