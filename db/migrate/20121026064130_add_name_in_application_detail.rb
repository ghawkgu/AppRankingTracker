class AddNameInApplicationDetail < ActiveRecord::Migration
  def up
    add_column :application_details, :name, :string
  end

  def down
    remove_column :application_details, :name
  end
end
