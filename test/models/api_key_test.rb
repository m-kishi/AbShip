require 'test_helper'

# ======================================================================
# ApiKey モデルのテスト
# ======================================================================
class ApiKeyTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
    @api_key = api_keys(:valid_key)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    assert_not_nil @api_key.user
    assert_equal @user.id, @api_key.user.id
  end

  # ------------------------------------------------------------
  # before_create activate
  # ------------------------------------------------------------
  test "before_create activate" do
    api_key = ApiKey.create(user_id: @user.id)
    assert_not_nil api_key.expires_at

    # 現在時刻との差分(Rational型)
    diff = api_key.expires_at.to_datetime - DateTime.now

    # 単位を分に変換
    diff = (diff * 24 * 60 ).to_i

    # 有効期限は30分なので，差分が30〜29分以内なら設定OK
    assert_in_delta 30, diff, 1
  end

  # ------------------------------------------------------------
  # before_create token_generate
  # ------------------------------------------------------------
  test "before_create token_generate" do
    api_key = ApiKey.create(user_id: @user.id)
    assert_not_nil api_key.token
  end

  # ------------------------------------------------------------
  # expired?
  # ------------------------------------------------------------
  test "expired? return true" do
    api_key = api_keys(:expired)
    assert api_key.expired?
  end

  # ------------------------------------------------------------
  # expired?
  # ------------------------------------------------------------
  test "expired? return false" do
    assert_not @api_key.expired?
  end

  # ------------------------------------------------------------
  # activate
  # ------------------------------------------------------------
  test "activate" do
    @api_key.activate
    assert_not_nil @api_key.expires_at

    # 現在時刻との差分(Rational型)
    diff = @api_key.expires_at.to_datetime - DateTime.now

    # 単位を分に変換
    diff = (diff * 24 * 60 ).to_i

    # 有効期限は30分なので，差分が30〜29分以内なら設定OK
    assert_in_delta 30, diff, 1
  end

end
