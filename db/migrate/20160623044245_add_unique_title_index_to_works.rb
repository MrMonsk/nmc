class AddUniqueTitleIndexToWorks < ActiveRecord::Migration
  def change
    add_index :works, [:user_id, :title], unique: true
  end
end
