require "net/http"
require "uri"
require "json"

class ZyteClient
  ZYTE_ENDPOINT = "https://api.zyte.com/v1/extract".freeze

  attr_reader :key

  def initialize(key:)
    @key = key
  end

  def extract(url:, options: {httpResponseBody: true}, json_parsing: true)
    response = response_from(options.merge(url: url))
    if response.code == "200"
      body = response.body
      return body unless json_parsing

      parsed = JSON.parse(body)
      parsed["httpResponseBody"] = Base64.decode64(parsed["httpResponseBody"]) if parsed["httpResponseBody"]
      parsed
    else
      raise ZyteClientError, "Failed to extract data from #{url}. Response: #{response.body}"
    end
  rescue StandardError => e
    raise ZyteClientError, "Failed to extract data from #{url}. Error: #{e.message}"
  end

  private

  def response_from(options)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = request_from(options)
      http.request(request)
    end
  end

  def request_from(options)
    Net::HTTP::Post.new(uri).tap do |req|
      req["Content-Type"] = "application/json"
      req.basic_auth(key, "")
      req.body = options.to_json
    end
  end

  def uri
    URI.parse(ZYTE_ENDPOINT)
  end
end

class ZyteClientError < StandardError; end
