class AddStaffToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :staff, :boolean, :default => false
  end

  def self.down
    remove_column :users, :staff
  end
end
