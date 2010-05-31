# == Schema Information
# Schema version: 20100528122309
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

    validates_presence_of :name, :department_id
end
