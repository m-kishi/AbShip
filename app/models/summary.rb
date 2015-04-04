class Summary < ActiveRecord::Base

  #年月順
  default_scope -> {
    order(:year, :mnth)
  }

  #1件取出
  scope :get, ->(y, m) {
    Summary.where("year=? AND mnth=?", y, m).first || Summary.empty(y, m)
  }

  #グラフデータ
  scope :graphic, ->(y, m) {
    summaries = []
    dtEnd = Date.new(y, m, 1)
    dtCrr = Date.new(y, m, 1) - 1.year
    while dtCrr <= dtEnd do
      summaries << Summary.get(dtCrr.year, dtCrr.month)
      dtCrr += 1.month
    end
    summaries
  }

  #名称からその月の支出を取得
  def get_cost_by_name(name)
    return 0 if name.blank?
    dtStr = Date.new(self.year, self.mnth, 1)
    dtEnd = dtStr + 1.month - 1.day
    sum = Expense.where("date BETWEEN ? AND ? AND name = ?", dtStr, dtEnd, name).group(:name).sum(:cost)
    sum[name]
  end

  #集計の登録処理
  def self.import
    Summary.delete_all
    summaries = connection.execute(summary_sql)
    summaries.each do |sum|
      Summary.create(
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

  private
  def self.summary_sql
    File.open("#{Rails.root}/db/sql/summary.sql").read
  end

  private
  def self.empty(y, m)
    sum = Summary.new
    sum.year = y
    sum.mnth = m
    sum.food = 0
    sum.otfd = 0
    sum.good = 0
    sum.frnd = 0
    sum.trfc = 0
    sum.play = 0
    sum.hous = 0
    sum.engy = 0
    sum.cnct = 0
    sum.medi = 0
    sum.insu = 0
    sum.othr = 0
    sum.earn = 0
    sum.bnus = 0
    sum.spcl = 0
    sum.prvi = 0
    sum.prvo = 0
    sum.ttal = 0
    sum.blnc = 0
    sum
  end

end
