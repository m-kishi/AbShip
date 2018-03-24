class Summary < ApplicationRecord
  belongs_to :user

  #年月順
  default_scope -> {
    order(:year, :mnth)
  }

  #1件取出
  scope :get, ->(y, m) {
    Summary.where("year=? AND mnth=?", y, m).first || Summary.empty(y, m)
  }

  # 集計タイトル
  def to_title
    sprintf("%04d年%02d月", year, mnth)
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
