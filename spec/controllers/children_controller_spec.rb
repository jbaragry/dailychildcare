require 'spec_helper'

describe ChildrenController do

  #Delete these examples and add some real ones
  it "should use ChildrenController" do
    controller.should be_an_instance_of(ChildrenController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
end
