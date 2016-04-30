module ShipHelper

  def to_currency(cost)
    (((cost < 0) ? '-' : '') + '&yen;' + cost.abs.to_s.reverse.gsub(/(\d{3})(?=\d)/,'\1,').reverse).html_safe
  end

  def total(year)
    (year.to_i == 9999) ? 'total' : ''
  end

  def to_jp_type(type)
    if type == "FOOD" then return "食費"  ; end
    if type == "OTFD" then return "外食費"; end
    if type == "GOOD" then return "雑貨"  ; end
    if type == "FRND" then return "交際費"; end
    if type == "TRFC" then return "交通費"; end
    if type == "PLAY" then return "遊行費"; end
    if type == "HOUS" then return "家賃"  ; end
    if type == "ENGY" then return "光熱費"; end
    if type == "CNCT" then return "通信費"; end
    if type == "MEDI" then return "医療費"; end
    if type == "INSU" then return "保険料"; end
    if type == "OTHR" then return "その他"; end
    if type == "EARN" then return "収入"  ; end
    if type == "TTAL" then return "合計"  ; end
    if type == "BLNC" then return "収支"  ; end
    if type == "BNUS" then return "特入"  ; end
    if type == "SPCL" then return "特出"  ; end
    if type == "PRVI" then return "秘密入"; end
    if type == "PRVO" then return "秘密出"; end
    return ""
  end

end
