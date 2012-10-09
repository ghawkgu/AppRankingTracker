class CreateApplicationDetails < ActiveRecord::Migration
  def change
    create_table :application_details do |t|
      t.string :application_id
      t.string :region_code
      t.text :summary
      t.text :icon_url

      t.timestamps
    end
  end
end
