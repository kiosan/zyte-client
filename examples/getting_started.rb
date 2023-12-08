require_relative '../lib/zyte-client.rb'
require_relative './config.rb'

url = 'https://www.google.com/search?q=Hola+Mundo'
client = ZyteClient.new(key: ZYTE_API_KEY)
html = client.extract(url)
File.open("data/getting-started.html", 'w') { |file| file.write(html) }
