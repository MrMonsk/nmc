class RemoveUserIdFromWorks < ActiveRecord::Migration
  def change
    remove_column :works, :user_id, :integer
  end
end
