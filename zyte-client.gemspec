Gem::Specification.new do |s|
    s.name        = 'zyte-client'
    s.version     = '1.0.6'
    s.date        = '2024-07-23'
    s.summary     = "Ruby library for operating Zyte API."
    s.description = "Ruby library for operating Zyte API."
    s.authors     = ["Leandro Daniel Sardi"]
    s.email       = 'leandro@massprospecting.com'
    s.files       = [
      'lib/zyte-client.rb',
      'zyte-client.gemspec'
    ]
    s.homepage    = 'https://github.com/massprospecting/zyte-client'
    s.license     = 'MIT'
    s.add_runtime_dependency 'uri', '>= 0.11.2'
    s.add_runtime_dependency 'net-http', '>= 0.2.0'
    s.add_runtime_dependency 'json', '>= 2.6.3'
end
