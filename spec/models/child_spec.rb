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

require 'spec_helper'

describe Child do
  before(:each) do
    @attr = {
      :name => "A Child",
      :user_id => 1,
      :department_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Child.create!(@attr)
  end

  it "should require a name" do
    no_name_child = Child.new(@attr.merge(:name => ""))
    no_name_child.should_not be_valid
  end

  it "should require a dept" do
    no_name_child = Child.new(@attr.merge(:department_id => ""))
    no_name_child.should_not be_valid
  end

  describe "micropost associations" do

    before(:each) do
      @child = Child.create(@attr)
      @mp1 = Factory(:micropost, :child => @child, :created_at => 1.day.ago)
      @mp2 = Factory(:micropost, :child => @child, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @child.should respond_to(:microposts)
    end

    it "should have the right microposts in the right order" do
      @child.microposts.should == [@mp2, @mp1]
    end

    it "should destroy associated microposts" do
      @child.destroy
      [@mp1, @mp2].each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

  end

 


end
