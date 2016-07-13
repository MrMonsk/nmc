class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :stage_name, :string
    add_column :profiles, :image, :string
  end
end
