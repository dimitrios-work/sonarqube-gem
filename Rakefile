# 
# Copyright (C) 2016 Dimitrios Dimas <dimitrios.work@outlook.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 

require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'rdoc/task'
require 'rake/testtask'
require 'rest-client'

spec = Gem::Specification.new do |s|
  s.name = 'sonarqube_gem'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'LICENSE']
  s.summary = 'Your summary here'
  s.description = s.summary
  s.author = ''
  s.email = ''
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "sonarqube_gem Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

namespace :setup_dev_environment do

  desc 'downloads the sonarqube docker image'
  task :download_docker_box do
    `docker pull sonarqube:5.2`
    if  $?.to_s.split(' ')[-1] == "0"
      puts 'successfully downloaded the sonarqube:5.2 docker image'
    else
      puts 'failed to download the sonarqube:5.2 docker image'
    end
  end

  desc 'downloads the sonarqube scanner'
  task :download_scanner do
    Dir.mkdir('./sonarqube_testing_server')
    Dir.chdir('./sonarqube_testing_server')
    IO.write('./sonar-scanner-2.6.1.zip', RestClient.get('https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-2.6.1.zip'))
  end
  
  task :all  => [:download_docker_box, :download_scanner]
end
  
namespace :teardown_dev_environment do
    
  desc 'stops docker'  
  task :stop_sonarqube do
    `docker ps | grep sonarqube`
  end
  
  desc 'removes the development environment files'
  task :remove_sonarqube do
    if FileUtils.rm_rf 'sonarqube_testing_server'
      puts "successfully deleted the sonarqube_test_server folder"
    else
      puts "couldn't delete the sonarqube_test_server folder"
    end
  end
  
  task :all => [:stop_sonarqube, :remove_sonarqube]
end

desc 'sets up the dev environment'
task :setup_dev_env => 'setup_dev_environment:all'

desc 'tears down the dev environment'
task :teardown_dev_env => 'teardown_dev_environment:all'

task :quick_build do
  `yard`
  `gem build sonarqube-client.gemspec`
  `sudo gem install ./sonarqube-client-0.0.0.gem`
end