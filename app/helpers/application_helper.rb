module ApplicationHelper

  #==============================
  # 通貨形式へ変換
  #==============================
  def to_currency(cost)
    (((cost < 0) ? '-' : '') + '&yen;' + cost.abs.to_s.reverse.gsub(/(\d{3})(?=\d)/,'\1,').reverse).html_safe
  end

end
