ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase

  # テーブル名とクラス名の紐付け
  set_fixture_class energies: Energie

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ActionDispatch::TestProcess
  include Sorcery::TestHelpers::Rails::Controller
# include Sorcery::TestHelpers::Rails::Integration

end
