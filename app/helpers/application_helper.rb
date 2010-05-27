module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "Daily Childcare"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
end
