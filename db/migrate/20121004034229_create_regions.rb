class CreateRegions < ActiveRecord::Migration
  def up
    create_table :regions, :id => false, :primary_key => "code" do |t|
      t.string :code, :limit => 2
      t.string :name_en
      t.string :name_ja
      t.boolean :enabled, :default => false

      t.timestamps
    end

    execute <<-SQL
      CREATE UNIQUE INDEX pk_regions ON regions (code);
      ALTER TABLE regions
        ADD PRIMARY KEY USING INDEX pk_regions;
    SQL
  end

  def down
    drop_table :regions
  end
end
