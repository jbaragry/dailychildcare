class Micropost < ActiveRecord::Base
  attr_accessible :content, :child_id

  belongs_to :child
  validates_presence_of :content, :child_id

  default_scope :order => 'created_at DESC'

end
