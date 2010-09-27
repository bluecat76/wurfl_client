require "wurfl/loader"
require "wurfl_client/lookup_helper.rb"
require "wurfl_client/ua_device_detector.rb"
require "pstore"

module WurflClient

  class LookupPreparer
    
    def initialize(set_config)
      config = set_config || {}
      @wurfl_path = config['wurfl_path'] || 'wurfl-custom.xml'
      @lookup_base_path = config['lookup_base_path'] || 'lookup/'
      
      @helper = LookupHelper.new(@lookup_base_path)
    end
    
    def prepareLookupTables
      @handsets = Wurfl::Loader.new.load_wurfl(@wurfl_path)
      @handsets.each do |wurfl_id, handset|
        target = UserAgentDeviceDetector.detect(handset.user_agent)
        if target.lookup_prefix && !(target.lookup_prefix =~ /DO_NOT_MATCH/)
          saveLookupTable target
        else
          puts "IGNORING UA: #{handset.user_agent}"
        end
      end
    end

    private
    
    def saveLookupTable(profile)
      store_filename = @helper.getStoreFilePath(profile.lookup_prefix)
      return if File.exists?(store_filename)
      
      puts "building store: #{store_filename}"
      
      # load similar user agent strings
      lookup_table = {}
      @handsets.each do |wurfl_id, handset|
        target = UserAgentDeviceDetector.detect(handset.user_agent)
        if target.lookup_prefix==profile.lookup_prefix
          lookup_table[wurfl_id] ||= handset
        end
      end
      
      # save as pstore
      PStore.new(store_filename).transaction {|ps| ps["handsets"] = lookup_table}
    end
    
  end
end
