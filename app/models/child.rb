# == Schema Information
# Schema version: 20100531113434
#
# Table name: children
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  user_id       :integer
#  department_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Child < ActiveRecord::Base
  attr_accessible :name, :department_id, :user_id

  has_many :microposts, :dependent => :destroy

  validates_presence_of :name, :department_id

  # fake email has to use with gravatar
  def gravatar_url()
    "http://www.gravatar.com/avatar" + Digest::MD5.hexdigest(:name) + "?d=monsterid"
  end
end
