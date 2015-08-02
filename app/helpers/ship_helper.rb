module ShipHelper

  def to_currency(cost)
    (((cost < 0) ? '-' : '') + '&yen;' + cost.abs.to_s.reverse.gsub(/(\d{3})(?=\d)/,'\1,').reverse).html_safe
  end

  def total(year)
    (year.to_i == 9999) ? 'total' : ''
  end

end
