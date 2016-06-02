class CreateBetaCandidates < ActiveRecord::Migration
  def change
    create_table :beta_candidates do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
