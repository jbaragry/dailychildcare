class AddPresentToChild < ActiveRecord::Migration
  def self.up
    add_column :children, :present, :boolean, :default => false
  end

  def self.down
    remove_column :children, :present
  end
end
