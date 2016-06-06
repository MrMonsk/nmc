class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.string :title
      t.string :image
      t.string :video
      t.string :audio
      t.timestamps null: false
    end
  end
end
