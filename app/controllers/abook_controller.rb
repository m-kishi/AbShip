class AbookController < ApplicationController
  include AbookHelper

  def expense
    @expenses = Expense.all
    @expense_selected = true
  end

  def summary
    year = params[:year].to_i
    mnth = params[:mnth].to_i
    @summary = Summary.get(year, mnth)
    @summary_selected = true
  end

  def graphic
    year = params[:year].to_i
    mnth = params[:mnth].to_i
    @graphic  = Graphic.get(year, mnth)
    @graphics = Graphic.data(year, mnth)
    @graphic_selected = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def balance
    @balances = Balance.all
    @balance_selected = true
    if @balances.empty?
      flash.now[:alert] = 'Balance Data is nothing.'
    end
  end

  def private
    @privates = Private.all
    @private_selected = true
  end

  def setfile
    @setfile_selected = true
  end

  def imports
    import(params[:file])
    redirect_to expense_path
  end

end
