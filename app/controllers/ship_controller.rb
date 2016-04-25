class ShipController < ApplicationController
  include ShipHelper

  def expense
    year = (params[:year] || Date.today.year ).to_i
    mnth = (params[:mnth] || Date.today.month).to_i
    @expense  = current_user.expenses.obj(year, mnth)
    @expenses = current_user.expenses.get(year, mnth)
    @expense_selected = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def summary
    year = (params[:year] || Date.today.year ).to_i
    mnth = (params[:mnth] || Date.today.month).to_i
    @summary = current_user.summaries.get(year, mnth)
    @summary_selected = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def graphic
    year = (params[:year] || Date.today.year ).to_i
    mnth = (params[:mnth] || Date.today.month).to_i
    @graphic  = current_user.graphics.get(year, mnth)
    @graphics = current_user.graphics.data(year, mnth)
    @graphic_selected = true
    respond_to do |format|
      format.html
      format.js
    end
  end

  def balance
    @balances = current_user.balances.all
    @balance_selected = true
  end

  def private
    @privates = current_user.privates.all
    @private_selected = true
  end

  def uploads
    @uploads_selected = true
  end

  def imports
    file = params[:file]
    if file.blank?
      flash.now[:alert] = 'DB file not selected.'
      @uploads_selected = true
      render :uploads
    else
      begin
        importer = Importer.new(current_user)
        importer.import(file)
      rescue => ex
        flash.now[:alert] = ex.message
        @uploads_selected = true
        render :uploads
      else
        redirect_to expense_path(year: Date.today.year, mnth: Date.today.month)
      end
    end
  end

  def summary_pdf
    summaries = current_user.summaries.all
    if summaries.empty?
      flash.now[:alert] = 'No Summaries Data.'
      render :nothing
    else
      report = SummaryPdf.create summaries
      send_data report.generate,
        :type        => "application/pdf",
        :filename    => "summary.pdf",
        :disposition => "inline"
    end
  end

  def balance_pdf
    balances = current_user.balances.all
    if balances.empty?
      flash.now[:alert] = 'No Balances Data.'
      render :nothing
    else
      report = BalancePdf.create balances
      send_data report.generate,
        :type        => "application/pdf",
        :filename    => "balance.pdf",
        :disposition => "inline"
    end
  end

  def energie_pdf
    el = current_user.energies.where(type: "ELE")
    gs = current_user.energies.where(type: "GAS")
    wt = current_user.energies.where(type: "WTR")
    energies = { el: el, gs: gs, wt: wt }
    if el.empty? || gs.empty? || wt.empty?
      flash.now[:alert] = 'No Energies Data.'
      render :nothing
    else
      report = EnergiePdf.create energies
      send_data report.generate,
        :type        => "application/pdf",
        :filename    => "energie.pdf",
        :disposition => "inline"
    end
  end

end
