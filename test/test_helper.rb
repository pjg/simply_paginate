ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

# Optional gems
begin
  require 'redgreen'
rescue LoadError
end

# Load Rails
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb'))

# Setup the database
config = YAML::load(IO.read(File.dirname(__FILE__) + '/config/database.yml'))

Dir.mkdir(File.dirname(__FILE__) + '/log') if !File.exists?(File.dirname(__FILE__) + '/log')
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/log/test.log')

db_adapter =
  begin
    require 'sqlite3'
    'sqlite3'
  end

if db_adapter.nil?
  raise "Could not select the database adapter. Please install Sqlite3 (gem install sqlite3-ruby)."
end


ActiveRecord::Base.establish_connection(config[db_adapter])

# Load the test database schema
load(File.dirname(__FILE__) + '/db/schema.rb')

# Load the plugin
require File.dirname(__FILE__) + '/../init.rb'

# Setup fixtures
require 'active_record/fixtures'

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures

  self.fixture_path = File.dirname(__FILE__) + "/fixtures"

  self.use_transactional_fixtures = false
  self.use_instantiated_fixtures  = true

  fixtures :all
end
