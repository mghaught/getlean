# Split Testing with Vanity Exercise

[Vanity](http://vanity.labnotes.org)


## Install Vanity

1. Add Vanity gem  

    Add to config/environment.rb

        gem.config "vanity"
  
        config.after_initialize do
          require "vanity"
        end


2. Point Vanity to your 'user'

    Add to application_controller.rb  

        use_vanity :current_user


3. Install dashboard (optional)

    Add route in routes.rb

        map.vanity "/vanity/:action/:id", :controller => :vanity


    Create controller vanity_controller.rb

        class VanityController < ApplicationController
          include Vanity::Rails::Dashboard
        end


## Use Vanity for a split test

1. Make split test experiment file

    Create the experiment file here: experiments/signup_test.rb
  
        ab_test "Name of test" do
          description "Some description you want to display on the dashboard"
          alternatives 2, 5, 10
          metrics :signup
        end


    Note: the name of the file is what you'll use to reference it.  So if the file is signup_test.rb, you'd use :signup_test

2. Define metric

    Once you have defined your split test, you need to create the metric to be referenced.  Above we passed :signup to the metrics call.  Thus we'd create the following metrics file:
    experiments/metrics/signup.rb
  
        metric "Signups" do
          description "Measures how many people signup."
        end


    There are a few variations of how metrics are defined.  Below is an example of using a model named_scope to fetch metrics results.

        model User.pro


3. Invoke test in your view

    This example will return a value, such as a price, to be displayed directly.

        <%= ab_test :signup_test %>

    Another way is to include view code in a block. You can either pass in a value from the split test to do something with or let the block be rendered only when the test returns true.

        <% ab_test :signup_test do %>
         ...view code here
        <% end %> 

4. Track conversions

    In order to know if your test converted we use the track! method.  This would usually be included in the action on a form submission or button click.

        track! :signup



