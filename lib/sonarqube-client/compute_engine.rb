# Copyright (C) 2017 Dimitrios Dimas <dimitrios.work@outlook.com>, Daniel Davison <sircapsalot@gmail.com>
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
  module ComputeEngine
    class ComputeEngine
      ENDPOINT = 'api/ce/'

      def initialize(connector)
        @connector = connector
      end

      # Search for tasks
      # Requires the system administration permission,
      # or project administration if componentId is set.
      #
      #  @param [Hash] options the options to pass
      #   Available options are:
      #     - componentID : ID of the component (project) to filter on
      #     - componentQuery : Limit search
      #     - maxExecutedAt : Maximum date of end of task processing (inclusive)
      #     - minSubmittedAt : minimum date of task submission (inclusive)
      #     - onlyCurrents : Filter on the last tasks
      #     - ps : Page size.
      #     - q : Limit search
      #     - status : Comma separated list of task statuses
      #     - type : Task type [e.g. REPORT]
      def activity(**options)
        JSON.parse(@connector[ENDPOINT + "activity?#{options.to_a.map {|p| "#{p[0]}=#{p[1]}" }.join('&')}"].get)
      end

      # Get the pending tasks, in-progress tasks and the last executed tasks of a given component
      # (usually a project). REquires the administration permission on the component
      #
      #  @param [Integer] component_id the id of the component
      def component(component_id)
        JSON.parse(@connector[ENDPOINT + "component?componentId=#{component_id}"].get)
      end

      # Give Compute Engine task details such as type, status, duration and associated component.
      # Requires 'Administer System' or 'Execute Analysis' permission.
      #
      #  @param [Integer] id the id of the task
      def task(id)
        JSON.parse(@connector[ENDPOINT + "task?id=#{id}"].get)
      end
    end
  end
end