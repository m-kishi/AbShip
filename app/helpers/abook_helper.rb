module AbookHelper
  require 'csv'

  UTF_8 = "UTF-8"
  ASCII = "ASCII-8BIT"

  def import(file)
    ActiveRecord::Base.transaction do
      Expense.delete_all
      CSV.parse(file.read) do |row|
        date, name, type, cost = row
        date = date.force_encoding(ASCII).encode(UTF_8, UTF_8)
        name = name.force_encoding(ASCII).encode(UTF_8, UTF_8)
        type = type.force_encoding(ASCII).encode(UTF_8, UTF_8)
        cost = cost.force_encoding(ASCII).encode(UTF_8, UTF_8)
        type = to_identifie(type)
        ActiveRecord::Base.connection.execute(
          "INSERT INTO expenses(date,name,type,cost) VALUES ('#{date}','#{name}','#{type}','#{cost}');"
        )
      end
      Summary.import
      Graphic.import
      Balance.import
      Private.import
    end
  end

  def to_identifie(type)
    if type == "食費"   then type = type.gsub(/^食費$/  , "FOOD"); return type; end
    if type == "外食費" then type = type.gsub(/^外食費$/, "OTFD"); return type; end
    if type == "雑貨"   then type = type.gsub(/^雑貨$/  , "GOOD"); return type; end
    if type == "交際費" then type = type.gsub(/^交際費$/, "FRND"); return type; end
    if type == "交通費" then type = type.gsub(/^交通費$/, "TRFC"); return type; end
    if type == "遊行費" then type = type.gsub(/^遊行費$/, "PLAY"); return type; end
    if type == "家賃"   then type = type.gsub(/^家賃$/  , "HOUS"); return type; end
    if type == "光熱費" then type = type.gsub(/^光熱費$/, "ENGY"); return type; end
    if type == "通信費" then type = type.gsub(/^通信費$/, "CNCT"); return type; end
    if type == "医療費" then type = type.gsub(/^医療費$/, "MEDI"); return type; end
    if type == "保険料" then type = type.gsub(/^保険料$/, "INSU"); return type; end
    if type == "その他" then type = type.gsub(/^その他$/, "OTHR"); return type; end
    if type == "収入"   then type = type.gsub(/^収入$/  , "EARN"); return type; end
    if type == "合計"   then type = type.gsub(/^合計$/  , "TTAL"); return type; end
    if type == "収支"   then type = type.gsub(/^収支$/  , "BLNC"); return type; end
    if type == "特入"   then type = type.gsub(/^特入$/  , "BNUS"); return type; end
    if type == "特出"   then type = type.gsub(/^特出$/  , "SPCL"); return type; end
    if type == "秘密入" then type = type.gsub(/^秘密入$/, "PRVI"); return type; end
    if type == "秘密出" then type = type.gsub(/^秘密出$/, "PRVO"); return type; end
  end

  def to_currency(cost)
    (((cost < 0) ? '-' : '') + '&yen;' + cost.abs.to_s.reverse.gsub(/(\d{3})(?=\d)/,'\1,').reverse).html_safe
  end

  def total(year)
    (year.to_i == 9999) ? 'total' : ''
  end

end
