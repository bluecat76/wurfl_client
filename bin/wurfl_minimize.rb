#!/usr/bin/env ruby
require "xml"
require "yaml"

# use this program to minimize the WURFL XML file, so it contains only capabilities you need.
# This can reduce the lookup store size considerably!

default_config = {
  'input_file' => 'wurfl-latest.xml',
  'output_file' => 'wurfl-default.xml',
  'capabilities' => ['brand_name', 'model_name', 'max_image_width', 'max_image_height', 'wta_voice_call']
}

def load_configuration(file_path)
  begin
    config = YAML::load_file(file_path)
  rescue
    nil
  end
end

def minimize_wurfl(configuration)
  # open input file
  doc = XML::Document.file(configuration['input_file'])

  # prepare output file
  out = XML::Document.new()
  out.root = XML::Node.new('wurfl')
  out.root << XML::Node.new('devices')
  devices_node = out.root.first

  # go through devices list
  doc.find("///devices/device").each do |element|
    wurfl_id = element.attributes["id"]
    user_agent = element.attributes["user_agent"]
    
    # copy node to output
    new_node = XML::Node.new('device')
    element.each_attr do |attr|
      new_node.attributes[attr.name] = attr.value 
    end

    element.each do |group|
      new_group = XML::Node.new('group')
      # check capabilities
      group.each do |cap|
        if configuration['capabilities'].include? cap.attributes["name"]
          # add capability
          new_cap = XML::Node.new('capability')
          cap.each_attr { |cap_attr| new_cap.attributes[cap_attr.name] = cap_attr.value }
          new_group << new_cap
        end
      end
      # copy group if not empty
      if new_group.children? 
        new_node << new_group
      end
    end
    
    # add node to output document
    devices_node << new_node
  end
  
  # save ouput file
  out.save(configuration['output_file'], :indent => true, :encoding => XML::Encoding::UTF_8)
end

config = load_configuration('wurfl_minimize.yml') || default_config
minimize_wurfl(config)
