require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Justin", last_name: "Barclay", email: "test@example.com", password: "foobarbaz", password_confirmation: "foobarbaz")
  end
  
  test "normal user model can be saved" do
    assert @user.valid?
    assert @user.save
  end

  test "user with a short password" do
     @user = User.new(first_name: "Justin", last_name: "Barclay", email: "test@example.com", password: "fooba", password_confirmation: "fooba")
     assert_not @user.valid?
  end

  test "user with mismatched password and password confirmation" do
    @user.password_confirmation = "thing"
    assert_not @user.valid?
  end

  test "user with an incorrect email" do
    @user.email = "thing@.co"
    assert_not @user.valid?
  end
end
