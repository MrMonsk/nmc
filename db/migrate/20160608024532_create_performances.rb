class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :image
      t.string :video
      t.string :audio
      t.timestamps null: false
    end

    add_index :performances, [:user, :title], unique: true
  end
end
