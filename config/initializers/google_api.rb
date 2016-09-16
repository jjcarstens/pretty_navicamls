config_file = ::Rails.root.join("config", "google_api.yml")

if ::File.exist?(config_file)
  GOOGLE_API_KEY = ::YAML.load_file(config_file)["api_key"]
else
  puts "WARN: Couldn't load #{config_file}. No Google API Key available to load maps."
end
