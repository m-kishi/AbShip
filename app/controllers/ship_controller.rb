class ShipController < ApplicationController
  include ShipHelper

  def expense
    year = params[:year].to_i
    mnth = params[:mnth].to_i
    @expense  = Expense.obj(year, mnth)
    @expenses = Expense.get(year, mnth)
    @expense_selected = true
    if @expenses.empty?
      flash.now[:alert] = 'Expense Data is nothing.'
    end
  end

  def summary
    year = params[:year].to_i
    mnth = params[:mnth].to_i
    @summary = Summary.get(year, mnth)
    @summary_selected = true
    respond_to do |format|
      format.html
      format.js
    end
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
    if @privates.empty?
      flash.now[:alert] = 'Private Data is nothing.'
    end
  end

  def uploads
    @uploads_selected = true
  end

  def imports
    file = params[:file]
    if file.blank?
      flash.now[:alert] = 'DB File not selected.'
      render :setfile
    else
      import(file)
      redirect_to expense_path(year: Date.today.year, mnth: Date.today.month)
    end
  end

  def summary_pdf
    report = SummaryPdf.create Summary.all
    send_data report.generate,
      :type        => "application/pdf",
      :filename    => "summary.pdf",
      :disposition => "inline"
  end

  def balance_pdf
    report = BalancePdf.create Balance.all
    send_data report.generate,
      :type        => "application/pdf",
      :filename    => "balance.pdf",
      :disposition => "inline"
  end

end
