require 'simple_cloud_logging'
require 'colorize'
require_relative '../lib/zyte-client.rb'
require_relative './urls/indeed-urls.rb'
require_relative './config.rb'

client = ZyteClient.new(key: ZYTE_API_KEY)
l = BlackStack::LocalLogger.new('indeed.log')

MAX = 640
URLS.each { |h|
    i = 0
    while i<=MAX
        s = ("%03d" % i).to_s
        l.logs "Scraping #{h[:name].blue} #{s.blue}... "
        name = h[:name]
        url = h[:url]
        html = client.extract(url)
        File.open("data/#{name}-#{s}.html", 'w') { |file| file.write(html) }
        i += 10
        l.logf "done".green
    end # while
}
