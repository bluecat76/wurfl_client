$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'wurfl_client/ua_device_detector'

class UserAgentDeviceDetectorTest < Test::Unit::TestCase
  def setup
  end

  def test_functionality
    dp = WurflClient::UserAgentDeviceDetector.detect ""
    assert_instance_of WurflClient::DeviceProfile, dp
  end

  def test_desktop
    dp = WurflClient::UserAgentDeviceDetector.detect "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.10) Gecko/20100914 Firefox/3.6.10"
    assert_equal true, dp.desktop?
    dp = WurflClient::UserAgentDeviceDetector.detect "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)"
    assert_equal true, dp.desktop?
    dp = WurflClient::UserAgentDeviceDetector.detect "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; en-us) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5"
    assert_equal true, dp.desktop?
  end

  def test_mobile
    dp = WurflClient::UserAgentDeviceDetector.detect "SAMSUNG-GT-S5230/S5230MMIG2 SHP/VPP/R5 Jasmine/0.8 Nextreaming SMM-MMS/1.2.0 profile/MIDP-2.1 configuration/CLDC-1.1"
    assert_equal true, dp.mobile?
    dp = WurflClient::UserAgentDeviceDetector.detect "BlackBerry8320/4.2.2 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/100"
    assert_equal true, dp.mobile?
    dp = WurflClient::UserAgentDeviceDetector.detect "Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16"
    assert_equal true, dp.mobile?
    dp = WurflClient::UserAgentDeviceDetector.detect "Mozilla/5.0 (Linux; U; Android 1.6; de-at; T-Mobile G1 Build/DRC92) AppleWebKit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1"
    assert_equal true, dp.mobile?
    dp = WurflClient::UserAgentDeviceDetector.detect "SonyEricssonK550i/R1JD Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1"
    assert_equal true, dp.mobile?
    dp = WurflClient::UserAgentDeviceDetector.detect "Nokia6230i/2.0 (03.80) Profile/MIDP-2.0 Configuration/CLDC-1.1"
    assert_equal true, dp.mobile?
  end

end
