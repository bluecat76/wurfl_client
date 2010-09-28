# this script needs the lookup folder to be set up!
require "wurfl_client"

class RackInterface

	def getJSON(handset)
		result = %Q{"WURFL-Client":1}
		if handset
			handset.keys.each do |key|
				result << %Q{,"#{key}":"#{handset[key]}"}
			end
		end
		"{#{result}}"
	end

	def call(env)
		user_agent = env["HTTP_USER_AGENT"]
		
		hs = WurflClient.detectMobileDevice(user_agent)

		[200, {"Content-Type" => "text/javascript"}, ["#{getJSON(hs)}"] ]
	end

end

run RackInterface.new
