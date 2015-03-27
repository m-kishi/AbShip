class CreatePrivates < ActiveRecord::Migration
  def change
    create_table :privates do |t|
      t.string  :date
      t.string  :name
      t.integer :cost
      t.integer :blnc
    end
  end
end
