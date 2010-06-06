# Split Testing with A/Bingo Exercise

[A/Bingo](http://www.bingocardcreator.com/abingo)

[Railscast of A/Bingo](http://railscasts.com/episodes/214-a-b-testing-with-a-bingo)


## Install A/Bingo

1. Install A/Bingo as a plugin:

script/plugin install git://git.bingocardcreator.com/abingo.git

2. Create the a/bingo migration and run it:

ruby script/generate abingo_migration
rake db:migrate

3. Install the dashboard (optional)

Create controller abingo_dashboard_controller.rb with the following include

class AbingoDashboardController < ApplicationController
  include Abingo::Controller::Dashboard
end

Add appropriate route to routes.rb such as:

  map.abingoTest "/abingo/:action/:id", :controller=> :abingo_dashboard

4. Tell A/Bingo how to identify your users

in application_controller.rb

  before_filter :set_abingo_identity

  def set_abingo_identity
    if current_user
      session[:abingo_id] = nil
      Abingo.identity = current_user.id
    else
      session[:abingo_id] ||= rand(10 ** 10)
      Abingo.identity = session[:abingo_id]
    end
  end
  
You may want to consider how to filter out robots.  Ryan Bates adds this to make all robots count as one:

    ...
    if request.user_agent =~ /\b(Baidu|Gigabot|Googlebot|libwww-perl|lwp-trivial|msnbot|SiteUptime|Slurp|WordPress|ZIBB|ZyBorg)\b/i  
      Abingo.identity = "robot"  
    ...  

## Adding a split test

1. Add the conditional to the view layer where you want to create the test

There are a few common approaches on how to use the ab_test method.  First, you create a conditional that will only execute the block if the test renders true and the subject is in the experiment group.

<% if ab_test "test_name" %>
  // content to be rendered
<% end %>  

Second, you may have the method return a value, either inline or in block form, from a list.  

<% title ab_test("signup_title", ["Sign up", "Registration", "Free Sign up"]) %> 

OR

<% ab_test("signup_title", ["Sign up", "Registration", "Free Sign up"]) do |signup_title| %>  
  <% title signup_title %>  
<% end %>


2. Recording conversions

Add this to your controller's action when a conversion has occurred.

  bingo! "test_name"

