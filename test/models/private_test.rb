require 'test_helper'

# ======================================================================
# Private モデルのテスト
# ======================================================================
class PrivateTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    p001 = privates(:p001)
    assert_not_nil p001.user
    assert_equal @user.id, p001.user.id
  end

end
