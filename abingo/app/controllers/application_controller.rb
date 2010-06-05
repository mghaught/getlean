class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :set_abingo_identity
  
    
protected

  def set_abingo_identity
    if current_user
      session[:abingo_id] = nil
      Abingo.identity = current_user.id
    else
      session[:abingo_id] ||= rand(10 ** 10)
      Abingo.identity = session[:abingo_id]
    end  
  end
  
end
