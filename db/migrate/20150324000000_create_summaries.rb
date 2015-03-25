class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.integer :year
      t.integer :mnth
      t.integer :food
      t.integer :otfd
      t.integer :good
      t.integer :frnd
      t.integer :trfc
      t.integer :play
      t.integer :hous
      t.integer :engy
      t.integer :cnct
      t.integer :medi
      t.integer :insu
      t.integer :othr
      t.integer :earn
      t.integer :bnus
      t.integer :spcl
      t.integer :prvi
      t.integer :prvo
      t.integer :ttal
      t.integer :blnc
    end
  end
end
