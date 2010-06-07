# Do-It-Yourself Metrics

There's great value and flexibility with owning the collection and display of your own metrics.  Below are two basic examples that can get you started on this path.

With Flingr we have identified several actionable metrics that we wish to track

* Signups - when a user is created
* Pro upgrades - when the user has opted to pay for a premium account
* Flings - when a user flings

These examples do not cover three other important metrics: visits, repeat use and fling backs.  We'll leave that as an exercise for the audience.


## Dirt Simple Dashboards 

The example dashboard is very basic but will get your data with little effort.  This technique also leverages your existing models to fetch the data.


1. Fetching your data

    Here we collect simple accounts based on activity per week.  We're only collection this week's and last week's data.

    In home_controller.rb

          def dashboard
            @current_signups = User.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
            @last_signups = User.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
            @current_pros = User.pro.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
            @last_pros = User.pro.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
            @current_flings = Fling.count(:conditions => {:created_at => 1.week.ago..Time.zone.now})
            @last_flings = Fling.count(:conditions => {:created_at => 2.weeks.ago..1.week.ago})
          end

2. View layer

    For displaying our counts we've opted for a simple html table view.  You can find this in views/home/dashboard.html.erb.

    That's it!  We said simple.   


## Visual dashboards with Open Flash Charts

Patrick McKenzie of A/Bingo provided this simple example of how he uses Open Flash Charts to display user data from his system.  You can view an example here:

http://www.bingocardcreator.com/stats/signups-per-day

Here's a quick walk through of how he put this together.  This example is fairly specific but it should give you plenty of inspiration on how you can adapt this to your application.

1. Create a wrapper method for calling Open Flash Chart

    Add this to application_controller.rb

        def open_flash_chart(height, width, data_url, div_name = nil)
          options = {}
          options[:height] = height
          options[:width] = width
          options[:swf_file_name] = "flash/open-flash-chart.swf"
          options[:div_name] = div_name unless div_name.nil?
          open_flash_chart_object_from_hash(data_url, options)
        end
  
2. Create a hash of data by user type  

        def Stat.signups_per_day
          Rails.cache.fetch("Stat.signups_per_day", :expires_in => 1.day) do
            signups = {}
            %w{trial guest registered}.each do |role|
              recs = User.find_by_sql(["select date(users.created_on) as date, count(*) as signup_count from users where role = ? group by date order by date ASC", role])
              signups[role] = {}
              recs.map {|rec| signups[role][rec.date] = rec.signup_count}
            end
            signups
          end
        end

3. Add controller actions for rendering charts

    Add to your controller, such as stat_controller.rb

        def signups_per_day
          @flash_chart_trials = open_flash_chart(550, 530, "/stats/signups-per-day-chart/trial", "trial_signups_chart")
          @flash_chart_guests = open_flash_chart(550, 530, "/stats/signups-per-day-chart/guest", "guests_signups_chart")
        end
  
        #route is /stats/signups-per-day-chart/:role
        def signups_per_day_chart
          raise "That is not a valid role!" unless %w{trial guest}.include? params[:role]
          title = Title.new("BCC Signups (#{params[:role].titleize.pluralize})")

          signups = Stat.signups_per_day[params[:role]]
          first_day = Date.parse("2009-07-05")

          bar = BarGlass.new
          day_values = Rails.cache.fetch("StatController.signups_per_day:#{params[:role]}", :expires_in => 1.day) do
            (first_day..(Date.today)).map {|date| (signups[date.to_s] || 0).to_i }
          end

          maximum_signups = 0
  
          week_values = day_values.in_groups_of(7).map do |week|
            signups_in_this_week = week.reject {|a| a.nil?}.sum
            maximum_signups = signups_in_this_week if signups_in_this_week > maximum_signups
            tooltip_for_this_week = (["Total: #{signups_in_this_week}"] + week.map {|day| day || 0}).join("<br>")
            val = BarValue.new(signups_in_this_week)
            val.set_tooltip(tooltip_for_this_week)
            val
          end

          bar.values = week_values

          x_axis = XAxis.new
          x_axis.steps = 7
          labels = XAxisLabels.new
          day_labels = (first_day..(Date.today)).map {|date| date.to_s }
          week_labels = day_labels.in_groups_of(7).map {|week| "#{week.first} ~ #{week.last}"}
          labels.labels = week_labels
          labels.set_vertical
          x_axis.labels = labels

          y_axis = YAxis.new
          scaling_factor = 100
          maximum_signups = ((maximum_signups / scaling_factor) + 1) * scaling_factor
          y_axis.set_range(0, maximum_signups, scaling_factor)

          chart = OpenFlashChart.new
          chart.set_title(title)
          chart.y_axis = y_axis
          chart.x_axis = x_axis
          chart.add_element bar
          render :text => chart.to_s
        end  




