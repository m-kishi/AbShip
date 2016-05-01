require 'test_helper'

# ======================================================================
# User モデルのテスト
# ======================================================================
class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # has_one api_key
  # ------------------------------------------------------------
  test "has_one api_key" do
    assert_not_nil @user.api_key
    assert_equal DateTime.new(2999, 12, 31, 0, 0, 0), @user.api_key.expires_at
  end

  # ------------------------------------------------------------
  # has_one api_key
  # ------------------------------------------------------------
  test "has_one api_key dependent destroy" do
    @user.destroy
    assert_equal 0, ApiKey.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # has_many expenses
  # ------------------------------------------------------------
  test "has_many expenses" do
    assert_not_nil @user.expenses
    assert_equal 5, @user.expenses.count
  end

  # ------------------------------------------------------------
  # has_many expenses
  # ------------------------------------------------------------
  test "has_many expenses dependent destroy" do
    @user.destroy
    assert_equal 0, Expense.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # has_many graphics
  # ------------------------------------------------------------
  test "has_many graphics" do
    assert_not_nil @user.graphics
    assert_equal 6, @user.graphics.count
  end

  # ------------------------------------------------------------
  # has_many graphics
  # ------------------------------------------------------------
  test "has_many graphics dependent destroy" do
    @user.destroy
    assert_equal 0, Graphic.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # has_many balances
  # ------------------------------------------------------------
  test "has_many balances" do
    assert_not_nil @user.balances
    assert_equal 4, @user.balances.count
  end

  # ------------------------------------------------------------
  # has_many balances
  # ------------------------------------------------------------
  test "has_many balances dependent destroy" do
    @user.destroy
    assert_equal 0, Balance.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # has_many privates
  # ------------------------------------------------------------
  test "has_many privates" do
    assert_not_nil @user.privates
    assert_equal 3, @user.privates.count
  end

  # ------------------------------------------------------------
  # has_many privates
  # ------------------------------------------------------------
  test "has_many privates dependent destroy" do
    @user.destroy
    assert_equal 0, Private.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # has_many summaries
  # ------------------------------------------------------------
  test "has_many summaries" do
    assert_not_nil @user.summaries
    assert_equal 7, @user.summaries.count
  end

  # ------------------------------------------------------------
  # has_many summaries
  # ------------------------------------------------------------
  test "has_many summaries dependent destroy" do
    @user.destroy
    assert_equal 0, Summary.where(user_id: @user.id).count
  end

  # ------------------------------------------------------------
  # validates mail presence
  # ------------------------------------------------------------
  test "validates mail presence" do
    params = {
      mail: '',
      password: 'password',
      password_confirmation: 'password'
    }
    user = User.new(params)
    assert_not user.valid?
    assert_includes user.errors.messages[:mail], "can't be blank"
  end

  # ------------------------------------------------------------
  # validates mail uniqueness
  # ------------------------------------------------------------
  test "validates mail uniqueness" do
    params = {
      mail: 'kishi@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
    user = User.new(params)
    assert_not user.valid?
    assert_includes user.errors.messages[:mail], "has already been taken"
  end

  # ------------------------------------------------------------
  # validates password presence
  # ------------------------------------------------------------
  test "validates password presence" do
    params = {
      mail: 'password@example.com',
      password: '',
      password_confirmation: ''
    }
    user = User.new(params)
    assert_not user.valid?
    assert_includes user.errors.messages[:password], "can't be blank"
  end

  # ------------------------------------------------------------
  # validates password confirmation
  # ------------------------------------------------------------
  test "validates password confirmation" do
    params = {
      mail: 'password@example.com',
      password: 'password',
      password_confirmation: 'password_confirmation'
    }
    user = User.new(params)
    assert_not user.valid?
    assert_includes user.errors.messages[:password_confirmation], "doesn't match Password"
  end

  # ------------------------------------------------------------
  # self.login?
  # ------------------------------------------------------------
  test "login? with valid api key" do
    api_key = api_keys(:valid_key)
    assert User.login?(api_key.token)
  end

  # ------------------------------------------------------------
  # self.login?
  # ------------------------------------------------------------
  test "login? with invalid token" do
    token = SecureRandom.hex + ";"
    assert_not User.login?(token)
  end

  # ------------------------------------------------------------
  # self.login?
  # ------------------------------------------------------------
  test "login? with expired" do
    api_key = api_keys(:expired)
    assert_not User.login?(api_key.token)
  end

  # ------------------------------------------------------------
  # self.find_by_token
  # ------------------------------------------------------------
  test "find_by_token with valid token" do
    token = api_keys(:valid_key).token
    user = User.find_by_token(token)
    assert_equal @user.id, user.id
  end

  # ------------------------------------------------------------
  # self.find_by_token
  # ------------------------------------------------------------
  test "find_by_token with invalid token" do
    token = SecureRandom.hex + ";"
    assert_raise(NoMethodError) {
      User.find_by_token(token)
    }
  end

  # ------------------------------------------------------------
  # self.find_by_token
  # ------------------------------------------------------------
  test "find_by_token with user not found" do
    api_key = api_keys(:user_not_found)
    assert_raise(ActiveRecord::RecordNotFound) {
      User.find_by_token(api_key.token)
    }
  end

  # ------------------------------------------------------------
  # activate
  # ------------------------------------------------------------
  test "activate with nil api_key" do
    @user.api_key = nil
    api_key = @user.activate
    assert_not_nil api_key
    assert_not api_key.expired?
  end

  # ------------------------------------------------------------
  # activate
  # ------------------------------------------------------------
  test "activate with existing api_key" do
    api_key = @user.activate
    assert_not_nil api_key
    assert_not api_key.expired?
  end

end
