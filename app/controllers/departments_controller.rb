class DepartmentsController < ApplicationController

  
  def show
    @dept = Department.find(params[:id])
  end

   def index
    @title = "All Departments"
    @departments = Department.all
  end

  def new
    @title = "Sign up"
  end


end
