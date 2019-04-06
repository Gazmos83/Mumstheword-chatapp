require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'li', "Name can't be blank"
    assert_select 'li', "Email is invalid"
    assert_select 'li', "Password is too short (minimum is 6 characters)"
    assert_select 'li', "Password confirmation doesn't match Password"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "The Hooft",
                                         email: "user@valid.com",
                                         password:              "123456",
                                         password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div', "Welcome to the Sample App!"
    assert_not flash.alert
  end
end
