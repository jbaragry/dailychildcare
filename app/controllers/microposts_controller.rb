class MicropostsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def create
    @child = Child.find_by_id(params[:micropost][:child_id])
    @micropost  = @child.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Update message created!"
      redirect_to(@child)
    else
      flash[:error] = "Please include an update message"
      redirect_to(@child)
    end
  end

  def destroy
    @child = Child.find_by_id(@micropost.child_id)
    @micropost.destroy
    redirect_to(@child)
  end

  private

  def authorized_user
    @micropost = Micropost.find(params[:id])
    redirect_to root_path unless current_user.staff?
  end


end
