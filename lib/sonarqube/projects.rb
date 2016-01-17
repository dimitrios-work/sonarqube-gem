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
    class Projects
      def initialize connector
        @connector=connector
      end
      
      #http://localhost:9000/api/projects/index
      def list
        JSON.parse(@connector['api/projects/index'].get)
      end
    
      #http://localhost:9000/api/projects/index?key=35
      #http://localhost:9000/api/projects/index?key=java-sonar-runner-simple
      def search_by_key key
        JSON.parse(@connector['api/projects/index?key=' + key].get)
      end
    
      #http://localhost:9000/api/projects/index?search=java
      def search_by_name name
        JSON.parse(@connector['api/projects/index?search=' + name].get)
      end
    end
    
    #http://localhost:9000/api/projects/index
    def list
      'api/projects/index'
    end
  
    #http://localhost:9000/api/projects/index?key=35
    #http://localhost:9000/api/projects/index?key=java-sonar-runner-simple  
    def search_by_key key
      'api/projects/index?key=' + key
    end

    #http://localhost:9000/api/projects/index?search=java
    def search_by_name name
      'api/projects/index?search=' + name
    end
  end
end