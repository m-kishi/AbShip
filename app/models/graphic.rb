class Graphic < ActiveRecord::Base

  # 年月順
  default_scope -> {
    order(:year, :mnth)
  }

  # 1件取得
  scope :get, ->(y, m) {
    Graphic.where("year=? AND mnth=?", y, m).first || Graphic.empty(y, m)
  }

  # グラフデータ取得
  scope :data, ->(y, m) {
    dtEnd = Date.new(y, m, 1)
    dtCrr = Date.new(y, m, 1) - 1.year
    query = []; value = []
    while dtCrr <= dtEnd
      query << "(year=? AND mnth=?)"
      value << dtCrr.year; value << dtCrr.month
      dtCrr += 1.month
    end
    data = []
    graphics = Graphic.where(query.join(" OR "), *value).to_a
    dtCrr = dtEnd - 1.year
    while dtCrr <= dtEnd
      grph = graphics.find {|g| g.year == dtCrr.year && g.mnth == dtCrr.month }
      data << (grph || Graphic.empty(dtCrr.year, dtCrr.month))
      dtCrr += 1.month
    end
    data
  }

  # グラフタイトル
  def to_title
    sprintf("%04d年%02d月", year, mnth)
  end

  # グラフデータ登録処理
  def self.import
    Graphic.delete_all
    graphics = connection.execute(graphic_sql)
    graphics.each do |grp|
      Graphic.create(
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

  private
  def self.graphic_sql
    File.open("#{Rails.root}/db/sql/graphic.sql").read
  end

  private
  def self.empty(y, m)
    grp = Graphic.new
    grp.year = y
    grp.mnth = m
    grp.food = 0
    grp.otfd = 0
    grp.engy_elc = 0
    grp.engy_gas = 0
    grp.engy_wtr = 0
    grp
  end

end
