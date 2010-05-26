# == Schema Information
# Schema version: 20100526143037
#
# Table name: employees
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Employee < ActiveRecord::Base
end
