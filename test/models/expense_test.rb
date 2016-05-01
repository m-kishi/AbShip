require 'test_helper'

# ======================================================================
# Expense モデルのテスト
# ======================================================================
class ExpenseTest < ActiveSupport::TestCase

  def setup
    @user = users(:kishi)
  end

  # ------------------------------------------------------------
  # belongs_to user
  # ------------------------------------------------------------
  test "belongs_to user" do
    e001 = expenses(:e001)
    assert_not_nil e001.user
    assert_equal @user.id, e001.user.id
  end

  # ------------------------------------------------------------
  # default_scope
  # ------------------------------------------------------------
  test "default_scope with order" do
    prev_id = 0
    Expense.all.each do |exp|
      assert prev_id < exp.id
      prev_id = exp.id
    end
  end

  # ------------------------------------------------------------
  # scope privates
  # ------------------------------------------------------------
  test "scope privates" do
    expenses = Expense.where(user_id: -1)
    assert expenses.all? {|exp| [ "PRVI", "PRVO" ].include(exp.type) }
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get" do
    expenses = Expense.get(2013, 7)
    assert_equal 8, expenses.length
  end

  # ------------------------------------------------------------
  # scope get
  # ------------------------------------------------------------
  test "scope get with not in range" do
    expenses = Expense.get(2000, 1)
    assert_empty expenses
  end

  # ------------------------------------------------------------
  # obj
  # ------------------------------------------------------------
  test "obj should return new StExpense" do
    expense = Expense.obj(2015, 5)
    assert_not_nil expense
    assert_equal "2015年05月", expense.to_title
  end

end
