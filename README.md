# sonarqube-gem
This will grow up to be a sonarqube gem

## Table of Contents
 - [Using the gem:](#using-the-gem)
 - [Setting up a dev environment for the gem](#setting-up-a-dev-environment-for-the-gem)
 
###Using the gem:
 - I'm using YARD for documentation, the YARDdoc for the latest released version is [here](http://www.rubydoc.info/gems/sonarqube-client), the following is only a quick how-to
 - [Installation:](#installation)
 - Usage:
   - [Creating a connection:](#creating-a-connection)
   - [Working with projects:](#working-with-projects)
 - Functional interface (prototype/beta):
   - [Functional interface](#functional-interface)
 - [Return values](#return-values)
   
####Installation:
```gem install 'sonarqube-client'```

####Create a connection:
```
sq = SonarQube::SonarQube.new('http://172.17.0.2:9000', 'admin', 'admin')
```
####Working with projects

######get all projects:
```
projects = sq.projects.get
=> [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">, #<OpenStruct id="4", k="bad2:project", nm="My bad project no.2", sc="PRJ", qu="TRK">]
```
######get a project by index
```
sq.projects.search_by_index 1
=> #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">
```
######get a project by key
```
sq.projects.search_by_key 'bad:project'
=> #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">
```
######get projects using a part of their name
```
sq.projects.name_contains 'bad'
=> [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">, #<OpenStruct id="4", k="bad2:project", nm="My bad project no.2", sc="PRJ", qu="TRK">]
```

####Functional interface
```
require 'sonarqube-client'
sc=SonarQube.sonarqube 'http://172.17.0.2:9000/', 'admin', 'admin'
puts sc.(Projects.get)

{"id"=>"1", "k"=>"bad:project", "nm"=>"My bad project", "sc"=>"PRJ", "qu"=>"TRK"}
{"id"=>"4", "k"=>"bad2:project", "nm"=>"My bad project no.2", "sc"=>"PRJ", "qu"=>"TRK"}

sc.(Projects.get).each do |project|
  puts project['id']
end  

1
4
```
####Return values:
The return values are openstructs or nil. There are examples below where the keys of the returned openstructs can be seen. Openstruct responses can be used as such:
```
sq.projects.name_contains('bad').each do |project|
  puts "found a project who's name contains the keyword \'bad\': #{project.nm}"
end  

found a project who's name contains the keyword 'bad': My bad project
found a project who's name contains the keyword 'bad': My bad project no.2
```

###Setting up a dev environment for the gem
you'll need: 
  - java (e.g. be able to run ```java -version``` and get the version back)
  - docker
    - docker daemon to be running 
    - your dev account to be able to run docker commands (you can achieve this by adding your user to the docker group, one way to do this is by running: ```sudo usermod -aG docker my_username```)
