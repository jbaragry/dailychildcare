class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :name
      t.string :img_uri
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
