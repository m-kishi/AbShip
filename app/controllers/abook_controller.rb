class AbookController < ApplicationController

  def expense
    @expenses = Expense.all
    @expense_selected = true
  end

  def summary
    @year = params[:year].to_i
    @mnth = params[:mnth].to_i
    dtCrr = Date.new(@year, @mnth, 1)
    @prevy = dtCrr - 1.year
    @prevm = dtCrr - 1.month
    @nextm = dtCrr + 1.month
    @nexty = dtCrr + 1.year
    @summary = Summary.get(@year, @mnth)
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
