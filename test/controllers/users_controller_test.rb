require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Pingu)
    @user2 = users(:Pinga)
    @unactivated_user = users(:lana)

  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                      email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@user2)
    assert_not @user2.admin?
    patch user_path(@user2), params: {
    user: { password:     'password'         ,
            password_confirmation: 'password',
            admin: true } }
    assert_not @user2.reload.admin?
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@user2)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    #   assert_redirected_to root_url
    assert_redirected_to login_url
  end

  test "should destroy user when logged in as an admin" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user2)
    end
  end

  test "should only show profiles of activated users" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
  #  assert_select 'div.pagination'
#    User.paginate(page: 1).each do |user|
#      if user.activated?
#        assert_select 'a[href=?]', user_path(user), text: user.name
#        unless user == @admin
#          assert_select 'a[href=?]', user_path(user), text: 'delete'
#        end
#      else
#        assert_select 'a[href=?]', user_path(user), false
#      end
#    end
  end

  test "Should not show unactivated user" do
    log_in_as (@user)
    get user_path(@unactivated_user)
    assert_redirected_to root_url
  end
end
