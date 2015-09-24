require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup 
    @user = User.new( name: "Fake Name", email: "fake@email.com", 
                      password: "foobarzz", password_confirmation: "foobarzz")
  end

  test "initial @user assignment should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "name should <= 50 chars" do
    @user.name = "a"*51
    assert_not @user.valid?
  end

  test "email should <= 255 chars" do
    @user.email = "a"*250 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    user2 = @user.dup
    user2.email = @user.email.upcase
    @user.save
    assert_not user2.valid?
  end

  test "password should be present" do
    @user.password = "   "
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = "a"*5
    assert_not @user.valid?
  end

end
