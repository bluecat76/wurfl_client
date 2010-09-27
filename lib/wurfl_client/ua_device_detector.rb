require "wurfl_client/device_profile"

module WurflClient
  
  # This class is used to determine a rough device profile from the given UserAgent string
  class UserAgentDeviceDetector
  
    def self.detect(ua_string)
      detectIphone(ua_string) || detectOtherMozilla(ua_string) || detectGeneric(ua_string) || DeviceProfile.new(:desktop)
    end

    private
    
    def self.detectIphone(ua_string)
      case ua_string
      when /iPod/
        return DeviceProfile.new('iphone', 'iphone_ipod')
      when /iPhone/
        os_ver = ua_string[/OS ([0-9_]+)/]
        prefix = 'iphone'
        prefix += "_#{os_ver[$1]}" if os_ver
        return DeviceProfile.new('iphone', prefix)
      end
    end
    
    def self.detectOtherMozilla(ua_string)
      if ua_string =~ /^Mozilla/
        case ua_string
        when /Nokia/
          os_ver = ua_string[/Nokia([a-zA-Z0-9\-\.]+)/]
          prefix = 'mozilla_nokia'
          prefix += "_#{os_ver[$1]}" if os_ver
          return DeviceProfile.mobile(prefix)
        when /Windows CE/
          os_ver = ua_string[/Windows CE; ([a-zA-Z0-9 \.]+)/]
          prefix = 'mozilla_wince'
          prefix += "_#{os_ver[$1]}" if os_ver
          return DeviceProfile.mobile(prefix)
        when /Symbian ?OS/
          return DeviceProfile.mobile('mozilla_symbian')
        when /PalmOS/
          return DeviceProfile.mobile('mozilla_palm')
        when /Motorola/
          return DeviceProfile.mobile('mozilla_motorola')
        when /MIDP-[0-9\.]/
          prefix = 'mozilla_' + ua_string[/MIDP-[0-9\.]+/]
          return DeviceProfile.mobile(prefix)
        when /phone/i
          return DeviceProfile.mobile('mozilla_phone')
        when /mobile/i
          return DeviceProfile.mobile('mozilla_mobile')
        else # other mozilla is considered desktop
          return DeviceProfile.desktop
        end
      end
    end
    
    def self.detectGeneric(ua_string)
      # TODO: detect desktop vs. mobile here!
      return DeviceProfile.mobile(ua_string[/^[0-9a-zA-z_\.\-]+/])
    end

  end
  
end
