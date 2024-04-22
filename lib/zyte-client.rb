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

    # call Zyte API's extract access point.
    #
    # url: the URL to extract.
    # options: additonal Zyte API's options to the default request. Default request is: {"url": url}.
    # json_parsing: if true, the response is parsed as JSON using jq command, and return the value of the `httpResponseBody` key. Default is true.
    #
    def extract(url:, json_parsing: true, options:{})
        data = {
            "url": url,
        }.merge(options)

        File.open('zyte.data.json', 'w') { |file| file.write(data.to_json) }

        if json_parsing
            cmd = "curl \
            --silent \
            --user #{self.key}: \
            --header 'Content-Type: application/json' \
            --data @zyte.data.json \
            --compressed \
            https://api.zyte.com/v1/extract \
            | jq --raw-output .httpResponseBody \
            | base64 --decode 
            "
        else
            cmd = "curl \
            --silent \
            --user #{self.key}: \
            --header 'Content-Type: application/json' \
            --data @zyte.data.json \
            --compressed \
            https://api.zyte.com/v1/extract 
            "
        end

        ret = `#{cmd}`

        return ret
    end # def zyte
    
end # class ZyteClient
