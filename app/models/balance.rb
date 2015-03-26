class Balance < ActiveRecord::Base

  #年度順
  default_scope -> {
    order(:year)
  }

  #収支の登録処理
  def self.import
    Balance.delete_all
    balances = connection.execute(balance_sql)
    balances.each do |bln|
      Balance.create(
        year:    bln["year"],
        earn:    bln["earn"],
        bnus:    bln["bnus"],
        expense: bln["expense"],
        special: bln["special"],
        balance: bln["balance"]
      )
    end
  end

  private
  def self.balance_sql
    File.open("#{Rails.root}/db/sql/balance.sql").read
  end

end
