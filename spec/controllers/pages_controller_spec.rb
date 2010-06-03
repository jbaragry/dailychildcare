require 'spec_helper'

describe PagesController do
  integrate_views

  before(:each) do
    @base_title = "Daily Childcare"
  end

  describe "GET 'home'" do

   describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_tag("title", "#{@base_title} | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @child = Factory(:child)
        @user.follow!(@child)
      end

      it "should have the right follower/following counts" 
    end

  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_tag("title",
                               @base_title + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_tag("title",
                               @base_title + " | About")
    end
  end

    describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_tag("title",
                               @base_title + " | Help")
    end
  end

end
