class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      
      t.string :name
      t.text :description
      t.string :work
      t.timestamps null: false
    end
  end
end
