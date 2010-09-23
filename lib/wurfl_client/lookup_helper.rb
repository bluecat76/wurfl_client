require "wurfl_client/device_profile"
require "wurfl/handset"
require "pstore"

module WurflClient

  class LookupHelper
    def self.encodeFilename(str)
      str.gsub(/[^a-zA-Z0-9_\.\-]/n) {|s| sprintf('%%%02x', s[0].ord) }
    end
    
    def initialize(lookup_base_path)
      @lookup_base_path = lookup_base_path
    end
    
    def getStoreFilePath(lookup_prefix)
      @lookup_base_path + LookupHelper.encodeFilename(lookup_prefix) + '.pstore'
    end

    def loadLookupTable(profile)
      store_filename = getStoreFilePath(profile.lookup_prefix)
      PStore.new(store_filename).transaction {|ps| ps["handsets"]}
    end
  end

end
