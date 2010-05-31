class DepartmentsController < ApplicationController
  before_filter :authenticate, :only => [:destroy]
  before_filter :admin_user,   :only => :destroy

  def show
    @department = Department.find(params[:id])
    @title = @department.name
  end

  def index
    @title = "All Departments"
    @departments = Department.all
  end

  def new
    @title = "New Department"
    @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      flash[:success] = "New department added"
      redirect_to @department
    else
      @title = "New Department"
      render 'new'
    end
  end

  def edit
    @title = "Edit Department"
    @department = Department.find(params[:id])
  end

  def update
    @department = Department.find(params[:id])

    if @department.update_attributes(params[:department])
      flash[:success] = "Department updated."
      redirect_to @department
    else
      @title = "Edit Department"
      render 'edit'
    end
  end

  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    flash[:success] = "Department removed."
    redirect_to departments_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
