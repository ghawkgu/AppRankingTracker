class AddLevelToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :level, :integer, :null => true
  end
end
