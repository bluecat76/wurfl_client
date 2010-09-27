module WurflClient

  # DeviceProfile stores "device context" information (desktop or mobile) 
  # and the "lookup prefix" used to find the correct lookup file
  class DeviceProfile
    attr_reader :context
    attr_reader :lookup_prefix

    def initialize(context, lookup_prefix)
      @context = context # like "desktop, mobile, iphone, etc"
      @lookup_prefix = lookup_prefix
    end
    
    def self.mobile(lookup_prefix)
      DeviceProfile.new(:mobile, lookup_prefix)
    end
    
    def self.desktop
      DeviceProfile.new(:desktop, nil)
    end
    
    def mobile?
      @context != :desktop
    end
    
    def desktop?
      @context == :desktop
    end
  end

end
