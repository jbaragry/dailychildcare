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

require 'spec_helper'

describe Child do
  before(:each) do
    @attr = {
      :name => "A Child",
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

  describe "relationships" do

    before(:each) do
      @child = Child.create!(@attr)
      @parent = Factory(:user)
    end

    it "should have a relationships method" do
      @child.should respond_to(:relationships)
    end

 
    it "should have a reverse_relationships method" do
      @child.should respond_to(:reverse_relationships)
    end

    it "should have a followers method" do
      @child.should respond_to(:followers)
    end

    it "should include the follower in the followers array" do
      @parent.follow!(@child)
      @child.followers.include?(@parent).should be_true
    end

  end

  describe "checkedin attribute" do

    before(:each) do
      @child = Child.create!(@attr)
    end

    it "should respond to checkedin" do
      @child.should respond_to(:checkedin)
    end

    it "should not be an admin by default" do
      @child.should_not be_checkedin
    end

    it "should be convertible to an admin" do
      @child.toggle!(:checkedin)
      @child.should be_checkedin
    end
  end


end
