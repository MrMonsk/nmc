class AlterPerformancesAddUsers < ActiveRecord::Migration
  def change
    add_index :performances, [:user_id, :title], unique: true
  end
end
