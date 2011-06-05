ENV["RAILS_ENV"] = "test"

#why does this need an environment?  We should load AR directly
#require 'rails'
#require 'active_record'
#require 'active_support'
#require 'active_support/core_ext' 
require File.expand_path("~/newap/config/environment")
require 'rails/test_help'
require 'test/unit'

require File.dirname(__FILE__) + '/../lib/acts_as_taggable'
require File.dirname(__FILE__) + '/../lib/tag'
require File.dirname(__FILE__) + '/../lib/tagging'

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DB'] || 'mysql')

load(File.dirname(__FILE__) + '/schema.rb')

#this has moved
#Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + '/fixtures/'
ActiveSupport::TestCase.fixture_path = File.dirname(__FILE__) + '/fixtures/' 
$LOAD_PATH.unshift(ActiveSupport::TestCase.fixture_path)

class ActiveSupport::TestCase
  #some no-longer-there way of accessing fixtures by label somehow?  these functions don't work, i can't get tests to run
  def things(sym)
    Things.find(:name => sym)
  end
    
  def tags(sym)
    Tags.find(:name => sym)
  end
  
  def taggings(sym)
    Taggings.find(:name => sym)
  end    
  
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # If you need to control the loading order (due to foreign key constraints etc), you'll
  # need to change this line to explicitly name the order you desire.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherent this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end