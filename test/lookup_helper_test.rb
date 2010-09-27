$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'wurfl_client/lookup_helper'

class LookupHelperTest < Test::Unit::TestCase
  def setup
  end

  def test_encode_filename
    s = WurflClient::LookupHelper.encodeFilename("br#l'@*ig$^/?!--and+zurg")
    assert_match /[a-z0-9\_\-\.]+/i, s
    s = WurflClient::LookupHelper.encodeFilename("simpletest09-10.20")
    assert_equal "simpletest09-10.20", s
  end
  
  def test_get_path
    lh = WurflClient::LookupHelper.new("path/")
    assert_match /^path\/.*test.*$/, lh.getStoreFilePath("test")
  end

  def test_load_table
    lh = WurflClient::LookupHelper.new(File.join(File.dirname(__FILE__), 'data'))
    p = WurflClient::DeviceProfile.mobile("iphone")
    handsets = lh.loadLookupTable(p)
    assert_instance_of Hash, handsets
    assert_instance_of Wurfl::Handset, handsets.first[1]
  end
end
