class CreateCategories < ActiveRecord::Migration
  def up
    create_table :categories, :id => false do |t|
      t.string :id
      t.string :label
      t.string :parent_id

      t.timestamps
    end
    # add_index :categories, :id, :name => 'pk_category', :unique
    execute <<-SQL
      ALTER TABLE categories
        ADD PRIMARY KEY (id)
    SQL
  end

  def down
    drop_table :categories
  end
end
