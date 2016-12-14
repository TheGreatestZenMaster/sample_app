require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "", 
                                      email: "bob@hotmail.com",
                                      password: "help", 
                                      password_confirmation: "me"} }
    end
    assert_template 'users/new'                                
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: {name: "Bob", 
                                      email: "bob@hotmail.com",
                                      password: "bobbob", 
                                      password_confirmation: "bobbob"} }
    end
    follow_redirect!
    assert_template "users/show"
  end
end
