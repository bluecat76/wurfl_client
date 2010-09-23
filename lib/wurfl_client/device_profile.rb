module WurflClient

  class DeviceProfile
    attr_reader :context
    attr_reader :lookup_prefix

    def initialize(context, lookup_prefix)
      @context = context # like "desktop|mobile"
      @lookup_prefix = lookup_prefix
    end
    
    def mobile(lookup_prefix)
      self.new(:mobile, lookup_prefix)
    end
    
    def desktop
      self.new(:desktop, nil)
    end
    
    def mobile?
      @context != :desktop
    end
    
    def desktop?
      @context == :desktop
    end
  end

end
