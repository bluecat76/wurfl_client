require "xml"

config = {
  :input_file => 'wurfl_latest.xml',
  :output_file => 'wurfl_custom.xml',
  :capabilities => ['brand_name', 'model_name', 'max_image_width', 'max_image_height', 'wta_voice_call']
}

def load_configuration(file_path)
  config = {}
end

def test_file
  doc = REXML::Document.new('<wurfl></wurfl>')
  doc.write 'test.xml'
  
  
#  devices = doc.root.add_element 'devices'
#  devices.add_element 'device', { 'id'=>'dinky' }
#  devices.add_element 'device', { 'id'=>'doink' }
#  doc.write 'test.xml'
end

def minimize_wurfl(configuration)
  doc = XML::Document.file(configuration[:input_file])
  doc.find("///devices/device").each do |element|
    wurfl_id = element.attributes["id"]
    user_agent = element.attributes["user_agent"]
      
    element.find("group/capability").each do |capability|
      h[capability.attributes["name"]] = capability.attributes["value"]
    end
  end
end

test_file