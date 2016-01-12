class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :name
      t.integer :project_id
      t.string :token
      t.timestamps null: false
    end
  end
end
