module CostHelper

  #==============================
  # 通貨形式へ変換(収支表用)
  #==============================
  def to_currency(cost)
    ((cost < 0) ? '-' : '') + '\\' + cost.abs.to_s.reverse.gsub(/(\d{3})(?=\d)/,'\1,').reverse
  end

end
