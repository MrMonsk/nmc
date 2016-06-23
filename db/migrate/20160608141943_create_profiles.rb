class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :bio
      t.string :url
      t.timestamps null: false
    end
  end
end
