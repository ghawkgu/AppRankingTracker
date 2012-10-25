class CreateRankingHistory < ActiveRecord::Migration
  def up
    create_table :ranking_histories do |t|
      t.timestamp :update_time, :null => false
      t.string :region_code, :limit => 2, :null => false
      t.string :category_id, :null => false
      t.integer :ranking, :null => false
      t.string :application_id
      t.timestamps
    end
  end

  def down
    drop_table :ranking_histories
  end
end
