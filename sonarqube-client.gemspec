Gem::Specification.new do |s|
  s.name        = 'sonarqube-client'
  s.version     = '0.0.1'
  s.date        = '2016-06-12'
  s.summary     = "A SonarQube client"
  s.description = "This gem can be used to interact with a SonarQube server using the REST API. This is an initial version and likely to be buggy and badly written. Testing/development is done against a sonarqube 5.2 server."
  s.authors     = ["Dimitrios Dimas"]
  s.email       = 'dimitrios.work@outlook.com'
  s.files       = ["lib/sonarqube-client.rb",
    "lib/sonarqube-client/client.rb",
    "lib/sonarqube-client/timemachine.rb",
    "lib/sonarqube-client/version.rb",
    "lib/sonarqube-client/logger.rb",
    "lib/sonarqube-client/projects.rb",
    "lib/sonarqube-client/issues.rb"
  ]
  s.homepage = 'http://rubygems.org/gems/sonarqube-client'
  s.license = 'GPL-2.0'
  s.add_runtime_dependency 'json', '1.8.3'
  s.add_runtime_dependency 'rest-client', '1.8.0'
  s.add_runtime_dependency 'nokogiri', '1.6.8'
  s.add_runtime_dependency 'logger', '1.2.8'
end