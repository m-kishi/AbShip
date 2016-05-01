class Importer
  require 'csv'

  UTF_8 = "UTF-8"
  ASCII = "ASCII-8BIT"

  def initialize(user)
    @user = user
  end

  def import(file)
    ActiveRecord::Base.transaction do
      expense_import(@user, file)
      summary_import(@user)
      graphic_import(@user)
      balance_import(@user)
      private_import(@user)
      energie_import(@user)
    end
  end

  private

  def expense_import(user, file)
    user.expenses.delete_all
    CSV.parse(file.read) do |row|
      date, name, type, cost = row
      date = date.force_encoding(ASCII).encode(UTF_8, UTF_8)
      name = name.force_encoding(ASCII).encode(UTF_8, UTF_8)
      type = type.force_encoding(ASCII).encode(UTF_8, UTF_8)
      cost = cost.force_encoding(ASCII).encode(UTF_8, UTF_8)
      type = to_identifie(type)
      ActiveRecord::Base.connection.execute(
        "INSERT INTO expenses(user_id,date,name,type,cost) VALUES ('#{user.id}','#{date}','#{name}','#{type}','#{cost}');"
      )
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

  def read_sql(id, type)
    case type
    when :summary; file = 'summary.sql'
    when :graphic; file = 'graphic.sql'
    when :balance; file = 'balance.sql'
    when :energie; file = 'energie.sql'
    end
    sql = File.open("#{Rails.root}/db/sql/#{file}").read
    sql.gsub('[user_id]', id.to_s)
  end

  def summary_import(user)
    user.summaries.delete_all
    sql = read_sql(user.id, :summary)
    summaries = ActiveRecord::Base.connection.execute(sql)
    summaries.each do |sum|
      user.summaries.create(
        year: sum["year"],
        mnth: sum["mnth"],
        food: sum["food"],
        otfd: sum["otfd"],
        good: sum["good"],
        frnd: sum["frnd"],
        trfc: sum["trfc"],
        play: sum["play"],
        hous: sum["hous"],
        engy: sum["engy"],
        cnct: sum["cnct"],
        medi: sum["medi"],
        insu: sum["insu"],
        othr: sum["othr"],
        earn: sum["earn"],
        bnus: sum["bnus"],
        spcl: sum["spcl"],
        prvi: sum["prvi"],
        prvo: sum["prvo"],
        ttal: sum["ttal"],
        blnc: sum["blnc"]
      )
    end
  end

  def graphic_import(user)
    user.graphics.delete_all
    sql = read_sql(user.id, :graphic)
    graphics = ActiveRecord::Base.connection.execute(sql)
    graphics.each do |grp|
      user.graphics.create(
        year: grp["year"],
        mnth: grp["mnth"],
        food: grp["food"],
        otfd: grp["otfd"],
        engy_elc: grp["engy_elc"],
        engy_gas: grp["engy_gas"],
        engy_wtr: grp["engy_wtr"]
      )
    end
  end

  def balance_import(user)
    user.balances.delete_all
    sql = read_sql(user.id, :balance)
    balances = ActiveRecord::Base.connection.execute(sql)
    balances.each do |bln|
      user.balances.create(
        year:    bln["year"],
        earn:    bln["earn"],
        bnus:    bln["bnus"],
        expense: bln["expense"],
        special: bln["special"],
        balance: bln["balance"]
      )
    end
  end

  def private_import(user)
    balance = 0
    user.privates.delete_all
    expenses = user.expenses.privates
    expenses.each do |exp|
      date = exp.date.strftime("%Y-%m")
      name = exp.name
      cost = exp.type == "PRVI" ? exp.cost : exp.type == "PRVO" ? -exp.cost : 0
      blnc = cost + balance
      user.privates.create(
        date: date,
        name: name,
        cost: cost,
        blnc: blnc
      )
      balance = blnc
    end
  end

  def energie_import(user)
    user.energies.delete_all
    sql = read_sql(user.id, :energie)
    energies = ActiveRecord::Base.connection.execute(sql)
    energies.each do |eng|
      user.energies.create(
        year:   eng["year"],
        type:   eng["type"],
        mnth04: eng["mnth04"],
        mnth05: eng["mnth05"],
        mnth06: eng["mnth06"],
        mnth07: eng["mnth07"],
        mnth08: eng["mnth08"],
        mnth09: eng["mnth09"],
        mnth10: eng["mnth10"],
        mnth11: eng["mnth11"],
        mnth12: eng["mnth12"],
        mnth01: eng["mnth01"],
        mnth02: eng["mnth02"],
        mnth03: eng["mnth03"],
      )
    end
  end

end
