class RemoveUserIdFromChild < ActiveRecord::Migration
  def self.up
    remove_column :children, :user_id
  end

  def self.down
    add_column :children, :user_id, :integer
  end
end
