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

require 'spec_helper'

describe Department do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :img_uri => "value for img_uri",
      :description => "value for description"
    }
  end

  it "should create a new instance given valid attributes" do
    Department.create!(@valid_attributes)
  end
end
