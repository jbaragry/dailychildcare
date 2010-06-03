class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :parent_id
      t.integer :offspring_id

      t.timestamps
    end
    add_index :relationships, :parent_id
    add_index :relationships, :offspring_id

  end

  def self.down
    drop_table :relationships
  end
end
