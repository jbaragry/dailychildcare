class AddNameUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :departments, :name, :unique => true
  end

  def self.down
    remove_index :departments, :name
  end

end
