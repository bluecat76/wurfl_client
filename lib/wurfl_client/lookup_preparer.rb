require "lookup_helper.rb"
require "pstore"

module WurflClient

  class LookupPreparer
    def initialize(lookup_base_path)
      @helper = LookupHelper.new(lookup_base_path)
    end
    
    def saveLookupTable(profile)
      store_filename = @helper.getStoreFilePath(profile.lookup_prefix)
      return if File.exists?(store_filename)
      
#     puts "building store: #{store_filename}"
      @@handsets ||= Wurfl::Loader.new.load_wurfl(@wurfl_path)
      
      # load similar user agent strings
      lookup_table = {}
      detector = UserAgentDeviceDetector.new
      @@handsets.each do |wurfl_id, handset|
        target = detector.detect(handset.user_agent)
        if target.lookup_prefix==profile.lookup_prefix
          lookup_table[wurfl_id] ||= handset
        end
      end
      
      # save as pstore
      PStore.new(store_filename).transaction {|ps| ps["handsets"] = lookup_table}
    end
    
    def prepareLookupTables
      @@handsets ||= Wurfl::Loader.new.load_wurfl(@wurfl_path)
      detector = UserAgentDeviceDetector.new
      @@handsets.each do |wurfl_id, handset|
        target = detector.detect(handset.user_agent)
        if target.lookup_prefix && !(target.lookup_prefix =~ /DO_NOT_MATCH/)
          saveLookupTable target
        else
          puts "IGNORING UA: #{handset.user_agent}"
        end
      end
    end
  end
end
