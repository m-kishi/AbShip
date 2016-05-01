require 'test_helper'

# ======================================================================
# Balance モデルのテスト
# ======================================================================
class BalanceTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    b001 = balances(:b001)
    assert_not_nil b001.user
    assert_equal @user.id, b001.user.id
  end

  # ------------------------------------------------------------
  # default_scope
  # ------------------------------------------------------------
  test "default scope with order" do
    year = 0
    Balance.all.each do |bln|
      assert year < bln.year
      year = bln.year
    end
  end

end
