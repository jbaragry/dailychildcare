class PagesController < ApplicationController

  

  def home
    @title = "Home"
    @departments = Department.all

    if signed_in?
      if current_user.admin
        @title += " - Admin"
      else
        if current_user.staff
          @title += " - Staff"
        else
          @title += " - Parent"
        end
      end
      redirect_to :controller => 'users', :id => current_user.id, :action => 'show'

    end
  end


  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
