class Expense < ActiveRecord::Base

  #カラム名として"type"を使うための設定
  self.inheritance_column = :_type_disabled

  #全件取得は登録順
  default_scope -> { order(:id) }

  #秘密収支の抽出
  scope :privates, -> {
    where("type IN ('PRVI', 'PRVO')")
  }

  scope :get, ->(y, m) {
    dtStr = Date.new(y, m, 1)
    dtEnd = dtStr + 1.month - 1.day
    Expense.where("date BETWEEN ? AND ?", dtStr, dtEnd)
  }

  StExpense = Struct.new(:year, :mnth) do
    def to_title
      sprintf("%04d年%02d月", year, mnth)
    end
  end

  def self.obj(y, m)
    StExpense.new(y, m)
  end

end
