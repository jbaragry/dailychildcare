# == Schema Information
# Schema version: 20100607133907
#
# Table name: relationships
#
#  id           :integer         not null, primary key
#  parent_id    :integer
#  offspring_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Relationship < ActiveRecord::Base
  attr_accessible :offspring_id

  belongs_to :parent, :foreign_key => "parent_id", :class_name => "User"
  belongs_to :offspring, :foreign_key => "offspring_id", :class_name => "Child"

  validates_presence_of :parent_id, :offspring_id

end
