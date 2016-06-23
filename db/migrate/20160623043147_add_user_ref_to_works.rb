class AddUserRefToWorks < ActiveRecord::Migration
  def change
    add_reference :works, :user, index: true, foreign_key: true
  end
end
