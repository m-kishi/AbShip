class CreateExpense < ActiveRecord::Migration

  def change
    create_table :expenses do |t|
      t.date    :date
      t.string  :name
      t.string  :type
      t.integer :cost
      t.references :user
    end
  end

end
