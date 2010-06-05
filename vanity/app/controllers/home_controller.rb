class HomeController < ApplicationController
  def index
  end

  def dashboard
    @current_signups = User.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
    @last_signups = User.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
    @current_pros = User.pro.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
    @last_pros = User.pro.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
    @current_flings = Fling.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
    @last_flings = Fling.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
  end
  
end
