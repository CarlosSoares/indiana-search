class CreateProjects < ActiveRecord::Migration

  def change
    create_table :projects do |t|
      t.integer :company_id, null: false
      t.string :name
      t.string :namespace
      t.timestamps null: false
    end
  end

end
