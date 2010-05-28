class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children do |t|
      t.string :name
      t.integer :user_id
      t.integer :department_id

      t.timestamps
    end
    add_index :children, :department_id

  end

  def self.down
    drop_table :children
  end
end
