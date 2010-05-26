# == Schema Information
# Schema version: 20100526111101
#
# Table name: departments
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  img_uri     :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Department < ActiveRecord::Base
  attr_accessible :name, :img_uri, :description

  ImgURLRegex = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(gif|png|jpg)$/ix

  validates_presence_of :name
  validates_format_of   :img_uri, :with => ImgURLRegex
  validates_uniqueness_of :name
end
