class CreateArtists < ActiveRecord::Migration
  def up
    create_table :artists, :id => false do |t|
      t.string :id
      t.string :name

      t.timestamps
    end
    execute <<-SQL
      ALTER TABLE artists
        ADD PRIMARY KEY (id)
    SQL
  end

  def down
    drop_table :artists
  end
end
