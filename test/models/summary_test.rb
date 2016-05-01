require 'test_helper'

# ======================================================================
# Summary モデルのテスト
# ======================================================================
class SummaryTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    s001 = summaries(:s001)
    assert_not_nil s001.user
    assert_equal @user.id, s001.user.id
  end

  # ------------------------------------------------------------
  # default_scope
  # ------------------------------------------------------------
  test "default scope with order" do
    prevy = 0
    prevm = 0
    Summary.all.each do |sum|
      if prevy == sum.year
        assert prevm < sum.mnth
      else
        assert prevy < sum.year
      end
      prevy = sum.year
      prevm = sum.mnth
    end
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get" do
    summary = Summary.get(2015, 4)
    assert_equal 2015, summary.year
    assert_equal    4, summary.mnth
    assert_equal 1000, summary.food
    assert_equal 2000, summary.otfd
    assert_equal 3000, summary.good
    assert_equal 4000, summary.frnd
    assert_equal 5000, summary.trfc
    assert_equal 6000, summary.play
    assert_equal 7000, summary.hous
    assert_equal 8000, summary.engy
    assert_equal 9000, summary.cnct
    assert_equal 1010, summary.medi
    assert_equal 2020, summary.insu
    assert_equal 3030, summary.othr
    assert_equal 4040, summary.earn
    assert_equal 5050, summary.bnus
    assert_equal 6060, summary.spcl
    assert_equal 7070, summary.prvi
    assert_equal 8080, summary.prvo
    assert_equal 9090, summary.ttal
    assert_equal 9999, summary.blnc
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get with empty" do
    summary = Summary.get(2002, 2)
    assert_equal 2002, summary.year
    assert_equal    2, summary.mnth
    assert_equal    0, summary.food
    assert_equal    0, summary.otfd
    assert_equal    0, summary.good
    assert_equal    0, summary.frnd
    assert_equal    0, summary.trfc
    assert_equal    0, summary.play
    assert_equal    0, summary.hous
    assert_equal    0, summary.engy
    assert_equal    0, summary.cnct
    assert_equal    0, summary.medi
    assert_equal    0, summary.insu
    assert_equal    0, summary.othr
    assert_equal    0, summary.earn
    assert_equal    0, summary.bnus
    assert_equal    0, summary.spcl
    assert_equal    0, summary.prvi
    assert_equal    0, summary.prvo
    assert_equal    0, summary.ttal
    assert_equal    0, summary.blnc
 end

  # ------------------------------------------------------------
  # to_title
  # ------------------------------------------------------------
  test "to_title" do
    s001 = summaries(:s001)
    assert_equal "2009年04月", s001.to_title

    s106 = summaries(:s106)
    assert_equal "2010年03月", s106.to_title
  end

end
