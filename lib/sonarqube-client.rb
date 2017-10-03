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

require File.dirname(__FILE__) + '/sonarqube-client/client.rb'
require File.dirname(__FILE__) + '/sonarqube-client/issues.rb'
require File.dirname(__FILE__) + '/sonarqube-client/logger.rb'
require File.dirname(__FILE__) + '/sonarqube-client/projects.rb'
require File.dirname(__FILE__) + '/sonarqube-client/qualitygates.rb'
require File.dirname(__FILE__) + '/sonarqube-client/timemachine.rb'
require File.dirname(__FILE__) + '/sonarqube-client/version.rb'
require File.dirname(__FILE__) + '/sonarqube-client/compute_engine.rb'





module SonarQube

  #@@logger=SonarQube::Logger::Logger.new

  #Initializes a connector object (RestClient::Resource), that stores the url and optionally the username
  #and password for the SonarQube server.
  # @example sq = SonarQube.new 'http://localhost:9000', 'username', 'password'
  # @param [String] server_url the url of the sonarqube server
  # @param [String] username (optional) username
  # @param [String] password (optional) password
  class SonarQube
    def initialize server_url, username='', password=''
      if [username, password].reduce(:+) == ''
        @connector=RestClient::Resource.new(server_url)
      else
        @connector=RestClient::Resource.new(server_url, username, password)
      end
    end

    #Returns a timemachine object, can also be used to invoke timemachine methods without having to store an object
    # @example my_tm = SonarQube.timemachine
    #   or if we don't want a persistent object:
    # @example puts \"coverage for my project is: \#\\{SonarQube.timemachine.get(my_awesome_project, coverage)\}\"
    # @return [TimeMachine::TimeMachine]
    def timemachine
      TimeMachine::TimeMachine.new(@connector)
    end

    #Returns a projects object, can also be used to invoke projects methods without having to store an object
    # @example my_proj = SonarQube.projects
    #   or if we don't want a persistent object:
    # @example puts \"available projects are: \#\\{SonarQube.projects.get\}\"
    # @return [Projects::Projects]
    def projects
      Projects::Projects.new(@connector)
    end

    #Returns a qualitygates object, can also be used to invoke qualitygates methods without having to store an object
    # @example my_qualitygates = SonarQube.qualitygates
    #   or if we don't want a persistent object:
    # @example puts \"available qualitygates are: \#\\{SonarQube.projects.get\}\"
    # @return [QualityGates::QualityGates]
    def qualitygates
      QualityGates::QualityGates.new(@connector)
    end

    #Returns an issues object, can also be used to invoke issues methods without having to store an object
    # @example issues = SonarQube.issues
    #   or if we don't want a persistent object:
    # @example puts \"the list with all the issues is: \#\\{SonarQube.issues.get\}\"
    # @return [TimeMachine::TimeMachine]
    def issues
      Issues::Issues.new(@connector)
    end

    #Returns a ComputeEngine object, can also be used to invoke ce methods without having to store an object
    # @example ce = SonarQube.ce
    #   or if we don't want a persistent object:
    # @return [ComputeEngine::ComputeEngine]
    def ce
      ComputeEngine::ComputeEngine.new(@connector)
    end
  end

  #Functional interface for this gem. Creates a curried proc, which can be called using other
  #functional style methods as parameters.
  #The returned curried Proc initialises/contains a RestClient::Resource object with all the necessary connectivity information
  # @example sq = SonarQube.sonarqube 'http://localhost:9000', 'admin', 'admin'
  # @return [Proc]
  def self.sonarqube(server_url, username='', password='')

    if [username, password].reduce(:+) == ''
      connector = RestClient::Resource.new server_url
    else
      connector = RestClient::Resource.new server_url, username, password
    end

    proc {|endpoint| connector[endpoint].get}.curry
  end

end
