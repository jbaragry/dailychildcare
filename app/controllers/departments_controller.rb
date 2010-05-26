class DepartmentsController < ApplicationController

  
  def show
    @dept = Department.find(params[:id])
  end

  def new
    @title = "Sign up"
  end


end
