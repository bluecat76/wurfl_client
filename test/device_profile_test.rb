$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'shoulda'
require 'wurfl_client/device_profile'

class DeviceProfileTest < Test::Unit::TestCase
  def setup
    @mobile_prefix = 'test_mobile'
  end

  def test_create_mobile
    dp = WurflClient::DeviceProfile.mobile(@mobile_prefix)
    assert_equal dp.mobile?, true
    assert_equal dp.desktop?, false
    assert_equal dp.lookup_prefix, @mobile_prefix
  end

  def test_create_desktop
    dp = WurflClient::DeviceProfile.desktop
    assert_equal dp.desktop?, true
    assert_equal dp.mobile?, false
    assert_equal dp.lookup_prefix, nil
  end

  def test_initialite
    dp = WurflClient::DeviceProfile.new(:mobile, @mobile_prefix)
    assert_equal dp.mobile?, true
    assert_equal dp.desktop?, false
    assert_equal dp.lookup_prefix, @mobile_prefix
  end
end
