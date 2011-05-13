require "wurfl_client/ua_device_detector"
require "wurfl_client/lookup_helper"
require "wurfl/user_agent_matcher"

module WurflClient
  @@lookup_base_path = 'lookup/'
  
  # change the path to the previously generated lookup files
  def self.setLookupBasePath(lookup_base_path)
    @@lookup_base_path = lookup_base_path
  end
  
  # main function to detect devices
  def self.detectMobileDevice(user_agent)
    profile = UserAgentDeviceDetector.detect(user_agent)
    if profile.mobile?
      # load prepared handset list
      lookup = LookupHelper.new(@@lookup_base_path)
      handsets = lookup.loadLookupTable(profile)
      
      if handsets
        uam = Wurfl::UserAgentMatcher.new(handsets)

        # return first matching entry
        hs = uam.match_handsets(user_agent).flatten.first
        if hs.class == Wurfl::Handset
        	hs["profile"] = profile.context
        end
        hs
      else
        # TODO: load complete table as fallback!
      end
    end
  end
end