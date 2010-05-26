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
end
