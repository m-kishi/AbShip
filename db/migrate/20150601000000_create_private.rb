class CreatePrivate < ActiveRecord::Migration

  def change
    create_table :privates do |t|
      t.string  :date
      t.string  :name
      t.integer :cost
      t.integer :blnc
      t.references :user
    end
  end

end
