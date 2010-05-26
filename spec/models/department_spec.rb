# == Schema Information
# Schema version: 20100526201609
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
    @attr = {
      :name => "Example Dept",
      :img_uri => "http://upload.wikimedia.org/wikipedia/commons/4/4d/Missing_barnstarPn.png",
      :description => "descript for dept"
    }
  end

  it "should create a new instance given valid attributes" do
    Department.create!(@attr)
  end

  it "should require a name" do
    no_name_dept = Department.new(@attr.merge(:name => ""))
    no_name_dept.should_not be_valid
  end

  it "should reject invalid img_uri" do
    uris = %w[bob.jpg, http:bob.jpg, http:/bob.jpg]
    uris.each do |i|
      invalid_uri_dept = Department.new(@attr.merge(:img_uri => i))
      invalid_uri_dept.should_not be_valid
    end
  end

  it "should reject duplicate department names" do
    Department.create!(@attr)
    dept_with_duplicate_name = Department.new(@attr)
    dept_with_duplicate_name.should_not be_valid
  end
end
