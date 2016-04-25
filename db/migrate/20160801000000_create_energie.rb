class CreateEnergie < ActiveRecord::Migration

  def change
    create_table :energies do |t|
      t.string  :year
      t.string  :type
      t.integer :mnth04
      t.integer :mnth05
      t.integer :mnth06
      t.integer :mnth07
      t.integer :mnth08
      t.integer :mnth09
      t.integer :mnth10
      t.integer :mnth11
      t.integer :mnth12
      t.integer :mnth01
      t.integer :mnth02
      t.integer :mnth03
      t.references :user
    end
  end

end
