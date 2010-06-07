# == Schema Information
# Schema version: 20100607133907
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :child_id

  belongs_to :child
  validates_presence_of :content, :child_id

  default_scope :order => 'created_at DESC'

end
