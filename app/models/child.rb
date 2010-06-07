# == Schema Information
# Schema version: 20100607133907
#
# Table name: children
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  department_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  checkedin     :boolean
#

class Child < ActiveRecord::Base
  attr_accessible :name, :department_id, :user_id, :present

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "offspring_id",
    :dependent => :destroy

  has_many :reverse_relationships, :foreign_key => "offspring_id",
    :class_name => "Relationship",
    :dependent => :destroy

  has_many :followers, :through => :reverse_relationships, :source => :parent


  validates_presence_of :name, :department_id


  # fake email has to use with gravatar
  def gravatar_url()
    "http://www.gravatar.com/avatar" + Digest::MD5.hexdigest(:name) + "?d=monsterid"
  end

end
