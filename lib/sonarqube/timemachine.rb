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
  module TimeMachine
    

    
    class TimeMachine
      @@endpoint='api/timemachine/'
      
      def initialize connector
        @connector=connector
      end
      
      #Returns the specified metrics of a project
      #@param [String] project_name The name of the project
      #@param [String] metrics A string that contains comma separated project metric keys/id's (can be found in: http://docs.sonarqube.org/display/SONAR/Metric+definitions)
      #@return [JSON] A JSON object with the project metrics
      def get project_name, metrics
        JSON.parse(@connector["#{@@endpoint}index?format=json&resource=#{project_name}&metrics=#{metrics}&toDateTime=&fromDateTime="].get)
      end
    end
    
    #example url:
    #http://localhost:9000/api/timemachine/index?resource=java-sonar-runner-simple&metrics=lines,toDateTime=,fromDateTime=
    def get(project, metrics)
      'api/timemachine/index?resource=' + project +'&metrics=' + metrics
    end
    
  end
end
