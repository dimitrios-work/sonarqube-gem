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

module SonarQube
  module Projects
    require 'ostruct'
    
    class Projects
      @@endpoint='/api/projects/'
      
      #Constructor
      #
      # @param [RestClient::Resource] connector The rest-client resource object
      #
      def initialize connector
        @connector=connector
      end
      
      #Returns all projects
      #
      # @return [Array<OpenStruct>] An Array of OpenStruct objects containing the project details (e.g. [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">]).
      def get
        response = JSON.parse(@connector["#{@@endpoint}index?format=json"].get, object_class: OpenStruct)
        return response.length > 0 ? response : nil
      end
    
      #Search for a project using the project index number (id)
      #
      # @param [String] index project index number to use in the search
      # @example puts \"this will return the project with id 47: #\\{search_by_key 47\}\"
      # @return [OpenStruct, nil] An OpenStruct object containing the project details (e.g. #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">) or nil.
      def search_by_index index
        JSON.parse(@connector["#{@@endpoint}index?format=json&key=#{index}"].get, object_class: OpenStruct)[0]
      end
   
      #Search for a project using the project key
      #
      # @param [String] key project key to use in the search
      # @example puts \"this will return all the project with key \'my:awesome:project\': #\\{search_by_key 'my:awesome:project'\}\"
      # @return [OpenStruct] An OpenStruct object containing the project details (e.g. #<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">) or nil.
      def search_by_key key
        JSON.parse(@connector["#{@@endpoint}index?format=json&key=#{key}"].get, object_class: OpenStruct)[0]
      end
      
      #Return all projects that their name contains the provided string
      #
      # @param [String] search_string search string to search with
      # @example puts \"this will return all the projects that their name contains the string \'java\': #\\{name_contains 'java'\}\"
      # @return [Array<OpenStruct>, nil] An Array of OpenStruct objects containing the project details (e.g. [#<OpenStruct id="1", k="bad:project", nm="My bad project", sc="PRJ", qu="TRK">]) or nil.
      def name_contains search_string
        response = JSON.parse(@connector["#{@@endpoint}index?format=json&search=#{search_string}"].get, object_class: OpenStruct)
        return response.length > 0 ? response : nil
      end
      
      #Delete a project with the specified id
      #
      # @param [String] id id of the project to be deleted
      # @return [JSON] A JSON object, containing all the project details (what details?).
      # @example puts \"this will delete the project with id 47: #\\{delete_id 47\}\"
      def delete_id id
        JSON.parse(@connector["#{@@endpoint}delete?id=#{id}"].get)
      end
      
      #Delete a project with the specified key
      #
      # @param [String] key key of the project to be deleted
      # @return [JSON] A JSON object, containing all the project details (what details?).
      # @example puts \"this will delete the project with the key \'my:awesome:project\': #\\{delete_key 'my:awesome:project'\}\"
      def delete_key key
        JSON.parse(@connector["#{@@endpoint}delete?key=#{key}"].get)
      end
    end
    
    #Returns all projects (functional interface)
    #
    # @return A JSON object, containing all the projects.
    #
    def get
      JSON.parse(@connector["#{@@endpoint}api/projects/index"].get)
    end
  
    #Search for a project by key (functional interface)
    #
    # == Parameters:
    # Project key
    #
    # == Returns:
    # A JSON object containing the project details (what details?).
    # 
    # == Example endpoints:
    #http://localhost:9000/api/projects/index?key=35
    #http://localhost:9000/api/projects/index?key=java-sonar-runner-simple
    def search_by_key key
      'api/projects/index?key=' + key
    end

    #Search for a project by name
    #
    # == Parameters:
    # Project name
    #
    # == Returns:
    # A JSON object, containing all the project details (what details?).
    # 
    # == Example endpoints:
    #http://localhost:9000/api/projects/index?search=java
    def search_by_name name
      'api/projects/index?search=' + name
    end
  end
end