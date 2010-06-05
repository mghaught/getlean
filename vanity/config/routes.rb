ActionController::Routing::Routes.draw do |map|
  
  map.devise_for :users
  map.resources :flings
  map.new_fling "/flings/new", :controller => :flings, :action => "new"
  map.create_fling "/flings", :controller => :flings, :action => "create", :method => :post
  map.fling "/flung/:id", :controller => :flings, :action => "show"
  
  map.dashboard "/dashboard", :controller => :home, :action => :dashboard
  map.vanity "/vanity/:action/:id", :controller => :vanity

  map.root :controller => 'home'
end
