# == Schema Information
# Schema version: 20100531113434
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Micropost do

  before(:each) do
    @child = Factory(:child)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @child.microposts.create!(@attr)
  end

  describe "child associations" do

    before(:each) do
      @micropost = @child.microposts.create(@attr)
    end

    it "should have a child attribute" do
      @micropost.should respond_to(:child)
    end

    it "should have the right associated user" do
      @micropost.child_id.should == @child.id
      @micropost.child.should == @child
    end
  end

  describe "validations" do

    it "should require a child id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @child.microposts.build(:content => "  ").should_not be_valid
    end

  end

end
