require 'spec_helper'

describe Relationship do

  before(:each) do
    @parent = Factory(:user)
    @child = Factory(:child)

    @relationship = @parent.relationships.build(:offspring_id => @child.id)
  end

  it "should create a new instance given valid attributes" do
    @relationship.save!
  end

  # a parent follows one or more children
  describe "follow methods" do

    before(:each) do
      @relationship.save
    end

    it "should have a offspring attribute" do
      @relationship.should respond_to(:parent)
    end

    it "should have the right follower" do
      @relationship.parent.should == @parent
    end

    it "should have a parent attribute" do
      @relationship.should respond_to(:offspring)
    end

    it "should have the right parent user" do
      @relationship.offspring.should == @child
    end

  end

  describe "validations" do

    it "should reqire a parent_id" do
      @relationship.parent_id = nil
      @relationship.should_not be_valid
    end

    it "should reqire a offspring_id" do
      @relationship.offspring_id = nil
      @relationship.should_not be_valid
    end
  end

end
