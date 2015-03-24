class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date    :date  #日付
      t.string  :name  #名称
      t.string  :type  #種別
      t.integer :cost  #金額
    end
  end
end
