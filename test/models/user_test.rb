require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup 
    @user = User.new( name: "Fake Name", email: "fake@email.com")
  end

  test "should be valid as is" do
    assert @user.valid?
  end

  test "name should not be empty" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should not be empty" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should be <= 50 chars" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should be <= 255 chars" do
    @user.email = "a"*246 +"@email.com"
  end

  test "email should have the right format" do
    valid_emails = ["john@example.com", "ted@cn.uk.org", "reich.sj1@gmail.com"]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "#{email.inspect} should be valid"
    end
  end

  test "email should not have the wrong format" do
    invalid_emails = ["john@example,com", "frank@@costanza"]
    invalid_emails.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email} should NOT be valid"
    end
  end
end
