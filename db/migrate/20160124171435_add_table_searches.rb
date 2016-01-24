class AddTableSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.integer :consumer_id, null: false
      t.string :query
      t.string :table_name
      t.string :field
      t.timestamps null: false
    end
  end
end
