ActionController::Routing::Routes.draw do |map|
  
  map.devise_for :users
  map.resources :flings
  map.fling "/flung/:id", :controller => :flings, :action => "show"
  
  map.dashboard "/dashboard", :controller => :home, :action => :dashboard
  map.abingo_dashboard "/abingo/:action/:id", :controller => :abingo_dashboard  

  map.root :controller => 'home'
end
