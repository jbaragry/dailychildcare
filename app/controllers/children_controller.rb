class ChildrenController < ApplicationController

  def show
    @child = Child.find(params[:id])
  end

  def new
    @title = "New Child"
  end


end
