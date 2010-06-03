class CreateMicroposts < ActiveRecord::Migration
  def self.up
    create_table :microposts do |t|
      t.string :content
      t.integer :child_id

      t.timestamps
    end
    add_index :microposts, :child_id
  end

  def self.down
    drop_table :microposts
  end
end
