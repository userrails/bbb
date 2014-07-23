class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource_or_scope)
      root_path
  end
  
  def is_loggedin?
    unless current_user
      flash[:alert] = "Please login"
      redirect_to homes_path
    end
  end
  
  def after_sign_up_path_for(resource_or_scope)
   root_path
  end
  
end