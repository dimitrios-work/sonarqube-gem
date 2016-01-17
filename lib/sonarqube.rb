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


require 'rest-client'
require 'nokogiri'
require 'json'
require 'logger'

require File.dirname(__FILE__) + '/sonarqube/client.rb'
require File.dirname(__FILE__) + '/sonarqube/issues.rb'
require File.dirname(__FILE__) + '/sonarqube/logger.rb'
require File.dirname(__FILE__) + '/sonarqube/projects.rb'
require File.dirname(__FILE__) + '/sonarqube/timemachine.rb'
require File.dirname(__FILE__) + '/sonarqube/version.rb'





module SonarQube

  #@@logger=SonarQube::Logger::Logger.new


  class SonarQube
    def initialize server_url, username='', password=''
      if [username, password].reduce(:+) == ''
        @connector=RestClient::Resource.new(server_url)      
      else
        @connector=RestClient::Resource.new(server_url, username, password)      
      end
    end
    
    def timemachine
      TimeMachine::TimeMachine.new(@connector)
    end
    
    def projects
      Projects::Projects.new(@connector)
    end
    
    def issues
      Issues::Issues.new(@connector)
    end
  end
  
  def sonarqube(server_url, username='', password='')
    if [username, password].reduce(:+) == ''
      proc {|endpoint| RestClient::Resource.new baseurl+endpoint}.curry
    else
      proc {|endpoint| RestClient::Resource.new baseurl+endpoint, a, b}.curry
    end
  end

end
