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
    @year = params[:year].to_i
    @mnth = params[:mnth].to_i
    dtCrr = Date.new(@year, @mnth, 1)
    @prevy = dtCrr - 1.year
    @prevm = dtCrr - 1.month
    @nextm = dtCrr + 1.month
    @nexty = dtCrr + 1.year
    @graphic_selected = true
    summaries = Summary.graphic(@year, @mnth)
    food = []
    otfd = []
    elec = []
    gass = []
    watr = []
    categories = []
    summaries.each do |sum|
      food << sum.food
      otfd << sum.otfd
      elec << sum.get_cost_by_name("電気代")
      gass << sum.get_cost_by_name("ガス代")
      watr << sum.get_cost_by_name("水道代")
      categories << sprintf("%02d月", sum.mnth)
    end
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "")
      f.chart({defaultSeriesType: "line"})
      f.xAxis(categories: categories, tickInterval: 2)
      f.yAxis(min: 0, max: 12500, allowDecimals: false)
      f.series(name: "食費  ", data: food)
      f.series(name: "外食費", data: otfd)
      f.series(name: "電気代", data: elec)
      f.series(name: "ガス代", data: gass)
      f.series(name: "水道代", data: watr)
      f.legend(align: "center", layout: "horizontal")
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
