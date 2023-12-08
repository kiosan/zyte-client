require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
#require 'selenium-webdriver'
#require 'watir'

class ZyteClient    
    attr_accessor :key

    def initialize(h={})
        self.key = h[:key] # mandatory
    end

    def extract(url)
        input = "{
            \"url\": \"#{url}\",
            \"httpResponseBody\": true
        }
        "
    
        File.open('zyte.input.json', 'w') { |file| file.write(input) }
    
        ret = `curl \
        --silent \
        --user #{self.key}: \
        --header 'Content-Type: application/json' \
        --data @zyte.input.json \
        --compressed \
        https://api.zyte.com/v1/extract \
        | jq --raw-output .httpResponseBody \
        | base64 --decode \
        `

        return ret
    end # def zyte
    
end # class ZyteClient
