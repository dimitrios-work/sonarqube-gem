Gem::Specification.new do |s|
  s.name        = 'sonarqube'
  s.version     = '0.0.0'
  s.date        = '2016-01-10'
  s.summary     = "SonarQube"
  s.description = "This gem can be used to interact with a SonarQube server using the REST API"
  s.authors     = ["Dimitrios Dimas"]
  s.email       = 'dimitrios.work@outlook.com'
  s.files       = ["lib/sonarqube.rb",
    "lib/sonarqube/client.rb",
    "lib/sonarqube/timemachine.rb",
    "lib/sonarqube/version.rb",
    "lib/sonarqube/logger.rb",
    "lib/sonarqube/projects.rb",
    "lib/sonarqube/issues.rb"
  ]
  s.homepage    =
    'http://rubygems.org/gems/sonarqube'
  s.license       = 'GPLv2'
end