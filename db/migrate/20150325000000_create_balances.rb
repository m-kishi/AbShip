class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.integer :year
      t.integer :earn
      t.integer :bnus
      t.integer :expense
      t.integer :special
      t.integer :balance
    end
  end
end
