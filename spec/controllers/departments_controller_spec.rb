require 'spec_helper'

describe DepartmentsController do
  integrate_views



  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      get 'index'
      response.should have_tag("title", /all departments/i)
    end
  end


  describe "GET 'show'" do

    before(:each) do
      @department = Factory(:department)
      # Arrange for Dept.find(params[:id]) to find the right user.
      Department.stub!(:find, @department.id).and_return(@department)
    end

    it "should be successful" do
      get :show, :id => @department
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @department
      response.should have_tag("title", /#{@department.name}/)
    end

    it "should include the dept's name" do
      get :show, :id => @department
      response.should have_tag("h2", /#{@department.name}/)
    end

    it "should have a profile image" do
      get :show, :id => @department
      response.should have_tag("img", :class => "image")
    end

    it "should include a list of the departments children"
    #      get :show, :id => @child
    #      response.should have_tag("h2", /#{@child.department_id}/)
    #    end

  end

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_tag("title", /New Department/i)
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :img_uri => "" }
        @department = Factory.build(:department, @attr)
        Department.stub!(:new).and_return(@department)
        @department.should_receive(:save).and_return(false)
      end

      it "should have the right title" do
        post :create, :department => @attr
        response.should have_tag("title", /new department/i)
      end

      it "should render the 'new' page" do
        post :create, :department => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Dept", :img_uri => "http://some.where/img.jpg" }
        @department = Factory(:department, @attr)
        Department.stub!(:new).and_return(@department)
        @department.should_receive(:save).and_return(true)
      end

      it "should redirect to the dept show page" do
        post :create, :department => @attr
        response.should redirect_to(department_path(@department))
      end

      it "should have a welcome message" do
        post :create, :department => @attr
        flash[:success].should =~ /New department added/i
      end
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @department = Factory(:department)
    end

    it "should be successful" do
      get :edit, :id => @department
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @department
      response.should have_tag("title", /edit department/i)
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @department = Factory(:department)
      Department.should_receive(:find).with(@department).and_return(@department)
    end

    describe "failure" do

      before(:each) do
        @invalid_attr = { :name => "", :img_uri => "" }
        @department.should_receive(:update_attributes).and_return(false)
      end

      it "should render the 'edit' page" do
        put :update, :id => @department, :department => {}
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @department, :department => {}
        response.should have_tag("title", /edit department/i)
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Department", :img_uri => "http://some.where/img.jpg" }
        @department.should_receive(:update_attributes).and_return(true)
      end

      it "should redirect to the show page" do
        put :update, :id => @department, :department => @attr
        response.should redirect_to(department_path(@department))
      end

      it "should have a flash message" do
        put :update, :id => @department, :department => @attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @department = Factory(:department)
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :id => @department
        response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :id => @department
        response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = Factory(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
        Department.should_receive(:find).with(@department).and_return(@department)
        @department.should_receive(:destroy).and_return(@department)
      end

      it "should destroy the dept" do
        delete :destroy, :id => @department
        response.should redirect_to(departments_path)
      end
    end
  end
end
