class Expense < ActiveRecord::Base

  #カラム名として"type"を使うための設定
  self.inheritance_column = :_type_disabled

  #全件取得は登録順
  default_scope -> { order(:id) }

end
