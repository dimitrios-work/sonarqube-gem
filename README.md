# sonarqube-gem
This will grow up to be a sonarqube gem

## Table of Contents
 - [Using the gem:](#using-the-gem)
 - [Setting up a dev environment for the gem](#setting-up-a-dev-environment-for-the-gem)
 - 
 
##Using the gem:
 - [Installation:](#installation)
 - [Return values](#return-values)
 - Usage:
   - [Creating a connection:](#creating-a-connection)
   - [Working with projects:](#working-with-projects)
 - Functional interface (prototype/beta):
   - [Functional interface](#functional-interface)
   
###Installation:
```gem install 'sonarqube-client'```

###Return values:
The return values are openstructs or nil. There are examples below where the keys of the returned openstructs can be seen. Openstruct responses can be used as such:
```
[11] pry(main)> sq.projects.name_contains('bad').each do |project|
[11] pry(main)*   puts "found a project who's name contains the keyword \'bad\': #{project.nm}"
[11] pry(main)* end  
found a project who's name contains the keyword 'bad': My bad project
found a project who's name contains the keyword 'bad': My bad project no.2
=> [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">, #<OpenStruct id="4", k="bad2:project", nm="My bad project no.2", sc="PRJ", qu="TRK">]
[12] pry(main)> 
```

###Creating a connection:
```
[5] pry(main)> sq = SonarQube::SonarQube.new('http://172.17.0.2:9000', 'admin', 'admin')
=> #<SonarQube::SonarQube:0x00000003caf5a0 @connector=#<RestClient::Resource:0x00000003caf488 @block=nil, @options={:user=>"admin", :password=>"admin"}, @url="http://172.17.0.2:9000">>
```
###Working with projects

get all projects:
```
[6] pry(main)> projects = sq.projects.get
=> [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">, #<OpenStruct id="4", k="bad2:project", nm="My bad project no.2", sc="PRJ", qu="TRK">]
```
get a project by index
```
[4] pry(main)> sq.projects.search_by_index 1
=> #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">
```
get a project by key
```
[5] pry(main)> sq.projects.search_by_key 'bad:project'
=> #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">
```
get projects using a part of their name
```
[7] pry(main)> sq.projects.name_contains 'bad'
=> [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">, #<OpenStruct id="4", k="bad2:project", nm="My bad project no.2", sc="PRJ", qu="TRK">]
```

###Functional interface
```
[2] pry(main)> require 'sonarqube-client'
=> true
[5] pry(main)> sc=SonarQube.sonarqube 'http://172.17.0.2:9000/', 'admin', 'admin'
=> #<Proc:0x000000038d4020>
[6] pry(main)> puts sc.(Projects.get)

{"id"=>"1", "k"=>"bad:project", "nm"=>"My bad project", "sc"=>"PRJ", "qu"=>"TRK"}
{"id"=>"4", "k"=>"bad2:project", "nm"=>"My bad project no.2", "sc"=>"PRJ", "qu"=>"TRK"}
=> nil
[7] pry(main)> 
[8] pry(main)> sc.(Projects.get).each do |project|
[8] pry(main)*   puts project['id']
[8] pry(main)* end  
1
4
=> [{"id"=>"1", "k"=>"bad:project", "nm"=>"My bad project", "sc"=>"PRJ", "qu"=>"TRK"}, {"id"=>"4", "k"=>"bad2:project", "nm"=>"My bad project no.2", "sc"=>"PRJ", "qu"=>"TRK"}]
[9] pry(main)> 
```
##Setting up a dev environment for the gem
you'll need: java (e.g. be able to run ```java -version``` and get the version back and docker (docker daemon to be running and your dev account to be able to run docker commands (you can achieve this by adding your user to the docker group, e.g. (as root): ```usermod -aG docker my_username```
