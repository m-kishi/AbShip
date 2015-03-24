class AbookController < ApplicationController

  def expense
    @expenses = Expense.all
    @expense_selected = true
  end

  def summary
    @summary_selected = true
  end

  def graphic
    @graphic_selected = true
  end

  def balance
    @balance_selected = true
  end

  def private
    @private_selected = true
  end

end
