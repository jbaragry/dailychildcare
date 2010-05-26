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

require 'spec_helper'

describe Employee do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Employee.create!(@valid_attributes)
  end
end
