
THIS PROJECT IS STILL UNDER CONSTRUCTION

![Gem version](https://img.shields.io/gem/v/adspower-client) ![Gem downloads](https://img.shields.io/gem/dt/adspower-client)

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
html = client.extract(url)
File.open("getting-started.html", 'w') { |file| file.write(html) }
```
