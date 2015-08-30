class CreateApiKey < ActiveRecord::Migration

  def change
    create_table :api_keys do |t|
      t.references :user
      t.string     :token
      t.datetime   :expires_at
      t.timestamps null: false
    end
  end

end
