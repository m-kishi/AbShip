class Energie < ActiveRecord::Base
  belongs_to :user

  #カラム名として"type"を使うための設定
  self.inheritance_column = :_type_disabled

  #年度順
  default_scope -> { order(:type, :year) }

end
