require 'spec_helper'

describe EmployeesController do

  #Delete these examples and add some real ones
  it "should use EmployeesController" do
    controller.should be_an_instance_of(EmployeesController)
  end


  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
end
