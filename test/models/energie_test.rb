require 'test_helper'

# ======================================================================
# Energie モデルのテスト
# ======================================================================
class EnergieTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    engE001 = energies(:engE001)
    engG001 = energies(:engG001)
    engW001 = energies(:engW001)
    assert_not_nil engE001.user
    assert_not_nil engG001.user
    assert_not_nil engW001.user
    assert_equal @user.id, engE001.user.id
    assert_equal @user.id, engG001.user.id
    assert_equal @user.id, engW001.user.id
  end

  # ------------------------------------------------------------
  # default_scope
  # ------------------------------------------------------------
  test "default scope with order" do
    ["ELE", "GAS", "WTR"].each do |type|
      year = 0
      Energie.where(type: type).each do |eng|
        assert year < eng.year.to_i
        year = eng.year.to_i
      end
    end
  end

end
