# Flingr Install Instructions

To run flingr on your laptop you have three variations of the application to run.  At the root of the tutorial repo you'll find them here:

/original
/abingo
/vanity

# Dependencies

The flingr examples are written in Rails 2.3.4.  To minimize gem use, I have vendored the few gems used.  Mysql is the current database used but the migrations have no mysql specific commands in them so you could use a different ActiveRecord compliant database.  The Vanity branch does require Redis.

# Getting It Running

1. Modify config/database.yml to contain your preferences for connection credentials.  It currently uses a database of flingr_dev with a user of flingr and password of open4me.

2. Create your database and fill with data
  
  rake db:create
  rake db:migrate
  rake db:seed

3. If using the vanity branch, modify config/redis.yml to connect to the redis instance you prefer.  Right now it uses the default localhost:6379.

4. Launch Rails.  cd into the branch directly and run script/server to launch rails.

5. Connect to localhost:3000 and get flinging

Note: all three branches have the same migrations so you can easily switch between branches and not worry about reset the database layer.

