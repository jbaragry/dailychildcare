class ChildrenController < ApplicationController

  before_filter :authenticate, :only => [:index, :destroy]
  before_filter :admin_user,   :only => :destroy

  def show
    @child = Child.find(params[:id])
    @microposts = @child.microposts.paginate(:page => params[:page])
    @micropost = Micropost.new(:child_id => @child.id)
    @title = CGI.escapeHTML(@child.name)
    @users = @child.followers
  end

  def new
    @child = Child.new
    @title = "New Child"
  end

  def create
    @child = Child.new(params[:child])
    if @child.save
      flash[:success] = "New child added"
      redirect_to @child
    else
      @title = "New Child"
      render 'new'
    end
  end

  def index
    @title = "All Children"
    @children = Child.paginate(:page => params[:page])
  end

  def edit
    @title = "Edit Child"
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])

    if @child.update_attributes(params[:child])
      flash[:success] = "Child updated."
      redirect_to @child
    else
      @title = "Edit Child"
      render 'edit'
    end
  end

  def destroy
    @child = Child.find(params[:id])
    @child.destroy
    flash[:success] = "Child removed."
    redirect_to children_path
  end

  def checkin
    @child = Child.find(params[:id])
    @child.toggle!(:checkedin)
    #render :text => "checked in"
    #render :partial => 'departments/dept_child', :locals => {:child => @child }

    @children = Child.find_all_by_department_id(@child.department_id)
    @checkedin = @children.select {|c| c.checkedin?}
    render :update do |page|
      page.replace "child_"+@child.id.to_s, :partial => "departments/dept_child", :locals => {:child => @child }
#      page.replace "dept_children", :partial => "departments/dept_children"
    end

  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end


end
