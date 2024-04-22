
![Gem version](https://img.shields.io/gem/v/zyte-client) ![Gem downloads](https://img.shields.io/gem/dt/zyte-client)

# Zyte Client

Ruby gem for operating [Zyte.com](https://www.zyte.com/) API.

**Outline:**

1. [Installation](#1-installation)
2. [Getting Started](#2-getting-started)

## 1. Installation

```bash
gem install zyte-client
```

You many need to install the **jq** package too.

```bash
sudo apt install jq
```

## 2. Getting Started

```ruby
require 'zyte-client'
url = 'https://www.google.com/search?q=Hola+Mundo'
client = ZyteClient.new(key: '<your Zyte API key here>')
html = client.extract(url: url)
File.open("getting-started.html", 'w') { |file| file.write(html) }
puts html
```

## 3. Zyte Options

You can specify additonal Zyte API's options to the default request. Default request is just this: {"url": url}.

```ruby
require 'zyte-client'
url = 'https://www.google.com/search?q=Hola+Mundo'
client = ZyteClient.new(key: '<your Zyte API key here>')
html = client.extract(
    url: url,
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
File.open("data/options.html", 'w') { |file| file.write(html) }
puts html
```

## 4. Parsing Zyte Response

By default the JSON response from Zyte is parsed and decoded using the bash commands `jq` and `base64`, and return the value of the `httpResponseBody` key.

If you want to get the entire JSON response, disable the `json_parsing` parameter.

```ruby
require 'zyte-client'
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
```