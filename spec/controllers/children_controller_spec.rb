require 'spec_helper'

describe ChildrenController do
  integrate_views

  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in, non-admin users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @user.toggle(:admin)
        @child = Factory(:child)
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      it "should have the right title" do
        get :index
        response.should have_tag("title", /all children/i)
      end

      it "should have an element for each child" do
        second_child = Factory(:child, :department_id => "2")
        third_child  = Factory(:child, :department_id => "3")
        get :index
        [@child, second_child, third_child].each do |child|
          response.should have_tag("li", /#{@child.name}/)
        end
      end
      
      it "should paginate children" do
        30.times { Factory(:child, :department_id => (1 + rand(3))) }
        get :index
        response.should have_tag("div.pagination")
        response.should have_tag("span", "&laquo; Previous")
        response.should have_tag("span", "1")
        response.should have_tag("a[href=?]", "/children?page=2", "2")
        response.should have_tag("a[href=?]", "/children?page=2", "Next &raquo;")
      end
      
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @child = Factory(:child)
      # Arrange for User.find(params[:id]) to find the right user.
      Child.stub!(:find, @child.id).and_return(@child)
    end

    it "should be successful" do
      get :show, :id => @child
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @child
      response.should have_tag("title", /#{@child.name}/)
    end

    it "should include the child's name" do
      get :show, :id => @child
      response.should have_tag("h2", /#{@child.name}/)
    end

    it "should have a profile image" do
      get :show, :id => @child
      response.should have_tag("img", :class => "image")
    end

    #    it "should include the child's department" do
    #      get :show, :id => @child
    #      response.should have_tag("h2", /#{@child.department_id}/)
    #    end

    it "should show the child's microposts" do
      mp1 = Factory(:micropost, :child => @child, :content => "Foo bar")
      mp2 = Factory(:micropost, :child => @child, :content => "Baz quux")
      get :show, :id => @child
      response.should have_tag("span.content", mp1.content)
      response.should have_tag("span.content", mp2.content)
    end
  end

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_tag("title", /New Child/)
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :department_id => "" }
        @child = Factory.build(:child, @attr)
        Child.stub!(:new).and_return(@child)
        @child.should_receive(:save).and_return(false)
      end

      it "should have the right title" do
        post :create, :child => @attr
        response.should have_tag("title", /new child/i)
      end

      it "should render the 'new' page" do
        post :create, :child => @attr
        response.should render_template('new')
      end
    end
 

    describe "success" do
    
      before(:each) do
        @attr = { :name => "New Child", :department_id => "1" }
        @child = Factory(:child, @attr)
        Child.stub!(:new).and_return(@child)
        @child.should_receive(:save).and_return(true)
      end
    
      it "should redirect to the chid show page" do
        post :create, :child => @attr
        response.should redirect_to(child_path(@child))
      end
    
      it "should have a welcome message" do
        post :create, :child => @attr
        flash[:success].should =~ /New child added/i
      end
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @child = Factory(:child)
    end

    it "should be successful" do
      get :edit, :id => @child
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @child
      response.should have_tag("title", /edit child/i)
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @child = Factory(:child)
      Child.should_receive(:find).with(@child).and_return(@child)
    end

    describe "failure" do

      before(:each) do
        @invalid_attr = { :name => "", :department_id => "" }
        @child.should_receive(:update_attributes).and_return(false)
      end

      it "should render the 'edit' page" do
        put :update, :id => @child, :child => {}
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @child, :child => {}
        response.should have_tag("title", /edit child/i)
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Child", :department_id => "1" }
        @child.should_receive(:update_attributes).and_return(true)
      end

      it "should redirect to the child show page" do
        put :update, :id => @child, :child => @attr
        response.should redirect_to(child_path(@child))
      end

      it "should have a flash message" do
        put :update, :id => @child, :child => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @child = Factory(:child)
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @child
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @child
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
        Child.should_receive(:find).with(@child).and_return(@child)
        @child.should_receive(:destroy).and_return(@child)
      end

      it "should destroy the user" do
        delete :destroy, :id => @child
        response.should redirect_to(children_path)
      end
    end

  end

 
end