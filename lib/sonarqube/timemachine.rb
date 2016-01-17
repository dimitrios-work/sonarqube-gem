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
      def initialize connector
        @connector=connector
      end
      
      #example url:
      #http://localhost:9000/api/timemachine/index?resource=java-sonar-runner-simple&metrics=lines,toDateTime=,fromDateTime=
      def get project, metrics
        JSON.parse(@connector['api/timemachine/index?resource=' + project +
              '&metrics=' + metrics + ',toDateTime=,fromDateTime='].get)
      end
    end
    
    #example url:
    #http://localhost:9000/api/timemachine/index?resource=java-sonar-runner-simple&metrics=lines,toDateTime=,fromDateTime=
    def get(project, metrics)
      'api/timemachine/index?resource=' + project +'&metrics=' + metrics
    end
    
  end
end
