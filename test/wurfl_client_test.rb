$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'wurfl_client/wurfl_client'

class WurflClientTest < Test::Unit::TestCase
  def setup
  end

  def test_functionality
    user_agent = 'Mozilla/5.0 (iPhone; U; CPU iPhone like Mac OS X; en-us)'
    WurflClient::setLookupBasePath(File.join(File.dirname(__FILE__), 'data'))
    device = WurflClient::detectMobileDevice(user_agent)
    assert_instance_of Wurfl::Handset, device
    assert_equal 'iPhone', device['model_name']
  end
end
