require_relative '../lib/zyte-client.rb'
require_relative './config.rb'

url = 'https://www.google.com/search?q=Hola+Mundo'
client = ZyteClient.new(key: ZYTE_API_KEY)
ret = client.extract(
    url: url,
    json_parsing: false,
    options: {
        "sessionContext": [
        {
            "name": "id",
            "value": "2"
        }
        ],
        "sessionContextParameters": {
            "actions": [
            {
                "action": "waitForTimeout",
                "timeout": 5,
                "onError": "return"
            }
            ]
        },            
        "httpResponseBody": true
    }
)
File.open("data/parsing.json", 'w') { |file| file.write(ret.to_json) }
puts ret.to_json
