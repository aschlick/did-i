ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base-after(:each) { Warden.test_reset! }
  end

  def sign_in
    login_as(User.first(), warden_scope(User.first()))
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
end
