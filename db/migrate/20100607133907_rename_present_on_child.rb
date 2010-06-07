class RenamePresentOnChild < ActiveRecord::Migration
  def self.up
    rename_column :children, :present, :checkedin
  end

  def self.down
    rename_column :children, :checkedin, :present
  end
end
