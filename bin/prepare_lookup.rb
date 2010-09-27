#!/usr/bin/env ruby
require "wurfl_client/lookup_preparer"
require "yaml"

def load_configuration(file_path)
  begin
    config = YAML::load_file(file_path)
  rescue
    nil
  end
end

preparer = WurflClient::LookupPreparer.new load_configuration('prepare_lookup.yml')
preparer.prepareLookupTables