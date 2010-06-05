RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "devise", :version => '1.0.7'


  config.gem "vanity"
  config.after_initialize do
    require "vanity"
  end

  config.time_zone = 'UTC'
end