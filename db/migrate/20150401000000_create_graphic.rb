class CreateGraphic < ActiveRecord::Migration

  def change
    create_table :graphics do |t|
      t.integer :year
      t.integer :mnth
      t.integer :food
      t.integer :otfd
      t.integer :engy_elc
      t.integer :engy_gas
      t.integer :engy_wtr
      t.references :user
    end
  end

end
