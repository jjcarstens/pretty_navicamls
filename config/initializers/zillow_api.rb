config_file = ::Rails.root.join("config", "zillow_api.yml")

if ::File.exist?(config_file)
  api_key = ::YAML.load_file(config_file)["api_key"]
  ZILLOW_API_URL = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=#{api_key}"
else
  puts "WARN: Couldn't load #{config_file}. No Zillow API Key available to reference."
end
