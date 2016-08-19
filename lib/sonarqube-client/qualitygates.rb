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
  module QualityGates
    require 'ostruct'
    
    class QualityGates
      ENDPOINT='/api/qualitygates/'
      
      #Constructor
      #
      # @param [RestClient::Resource] connector The rest-client resource object
      #
      def initialize connector
        @connector=connector
      end
      
      #Returns all qualitygates
      #
      # @return [Array<OpenStruct>] An Array of OpenStruct objects containing the qualitygate details.
      def get
        JSON.parse(@connector["#{ENDPONT}list"].get, object_class: OpenStruct)
      end
    
      #Returns the project_status details
      #
      # @return [Array<OpenStruct>] An Array of OpenStruct objects containing the project_status.
      def project_status projectKey
        JSON.parse(@connector["#{ENDPONT}project_status?projectKey=#{projectKey}"].get, object_class: OpenStruct)
      end

    end
  end
end
