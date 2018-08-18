require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not save user without name" do
    user = User.new
    assert_not user.save
  end

  test "should save user with a name" do
    user = User.new(name: 'Joe')
    assert user.save
  end

  test "should save user and create a token for the user" do
    user = User.new(name: 'Joe')
    user.save
    assert_not_empty(user.token)
  end

end
