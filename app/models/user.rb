# == Schema Information
# Schema version: 20100526201609
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email
EmailRegex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :name, :email
  validates_format_of   :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false
end
