class CreateApplications < ActiveRecord::Migration
  def up
    create_table :applications, :id => false do |t|
      t.string :id
      t.string :bundle_id
      t.boolean :iphone
      t.boolean :ipad

      t.string :artist_id

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE applications
        ADD PRIMARY KEY (id)
    SQL
  end

  def down
    drop_table :applications
  end
end
