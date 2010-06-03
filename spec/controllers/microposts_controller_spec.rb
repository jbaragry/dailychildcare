require 'spec_helper'

describe MicropostsController do

  integrate_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @child = Factory(:child)
      @attr = { :content => "Lorem ipsum", :child_id => "1" }
      Child.should_receive(:find_by_id).with(@attr[:child_id]).and_return(@child)
      @micropost = Factory(:micropost, @attr.merge(:child => @child))
      @child.microposts.stub!(:build).and_return(@micropost)
    end

    describe "failure" do

      before(:each) do
        @micropost.should_receive(:save).and_return(false)
      end

      it "should render the child page" do
        post :create, :micropost => @attr
        flash[:notice].should =~ /please include an update message/i
        response.should redirect_to(child_path(@child))
      end
    end

    describe "success" do

      before(:each) do
        @micropost.should_receive(:save).and_return(true)
      end

      it "should redirect to the child page" do
        post :create, :micropost => @attr
        response.should redirect_to(child_path(@child))
      end
      
      it "should have a flash message" do
        post :create, :micropost => @attr
        flash[:success].should =~ /update message created!/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @parentuser = test_sign_in(Factory(:user))
        @child = Factory(:child)
        @attr = { :content => "Lorem ipsum" }
        @micropost = Factory(:micropost, @attr.merge(:child => @child))
      end

      it "should deny access for non-authorized" do
        @micropost.should_not_receive(:destroy)
        delete :destroy, :id => @micropost
          response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do
    
      before(:each) do
        @staffuser = test_sign_in(Factory(:user, :staff => true))
        @child = Factory(:child)
        @micropost = Factory(:micropost, :child => @child)
        Micropost.should_receive(:find).with(@micropost).and_return(@micropost)
      end
    
      it "should destroy the micropost" do
        @micropost.should_receive(:destroy).and_return(@micropost)
        delete :destroy, :id => @micropost
        response.should redirect_to(child_path(@child))
      end
    end
  end


end
