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
  module Issues

    class Issues 
      @@endpoint='api/issues/'
      
      #Constructor
      #
      # @param [RestClient::Resource] connector The rest-client resource object
      #
      def initialize connector
        @connector=connector
      end
      
      #Search for issues by name
      #
      # @param names The key or keys (comma-separated list) to be used in the search
      # @return A JSON object, containing all the issues found.
      #
      def search_by_name names
        JSON.parse(@connector[@@endpoint + "search?componentKeys=#{names}"].get)
      end
      
      #Search for issues older than a date/datetime
      #
      # @param [String] date A string representation of a date or datetime in ISO
      #   format (example: 2015-01-01 or 2015-01-01T11:01:01+0100)
      # @return A JSON object, containing all the issues created after the given date.
      #
      def older_than date
        JSON.parse(@connector[@@endpoint + "search?createdBefore=#{date}"].get)
      end
      
      #Returns all issues created between the current date/time and the amount of days/time provided
      #
      # @param [String] date A string representation of a date or datetime in ISO 
      #   format, that specifies how far back from the current date/time we want 
      #   to look for new issues (example: 2015-01-01 or 2015-01-01T11:01:01+0100)
      # @return [JSON] A JSON object, containing all the issues created in the previous time/days specified.
      #
      def in_past date
        JSON.parse(@connector[@@endpoint + "search?createdInLast=#{date}"].get)
      end
      
      #Add a comment to an issue
      #
      # @param [String] key The issue key
      # @param [String] comment (optional, the default value is an empty string) The comment we want to add.
      # @return [JSON] A JSON object, containing all the issues.
      #
      def add_comment key, comment=''
        JSON.parse(@connector[@@endpoint + "add_comment?format=json,issue=#{key},text=#{comment}"].get)
      end
      
      #Assigns an issue to a user
      #
      # @param [String] issue The issue key
      # @param [String] username The username (login) of the assignee
      # @return [A JSON object, containing all the issues.
      #
      def assign issue, username=''
        JSON.parse(@connector[@@endpoint + "assign?issue=#{issue},assignee=#{username}"].get)
      end
      
      #Returns scm users (usernames or emails) that have authored code with issues
      #
      # @param [String] search_string A string that will be used to search (regex match equivalent to /.\*search_string.\*/) for 
      #   authors usernames or emails (e.g. for git it'll be used to search for what's configured in user.name or user.email).
      # @return [JSON] A JSON object, containing all the authors.
      #
      def get_committers search_string
        JSON.parse(@connector[@@endpoint + "authors?ps=2147483647&q=#{search_string}"].get)
      end
      
      #Returns the changelog of an issue
      #
      # @param [String] key The issue key.
      # @return [JSON] A JSON object, containing all the changelog.
      #
      def changelog key
        JSON.parse(@connector[@@endpoint + "changelog?format=json,issue=#{key}"].get)
      end

      #Returns all issues
      #
      # @return [JSON] A JSON object, containing all the issues.
      #
      def get
        JSON.parse(@connector[@@endpoint + 'search'].get)
      end
      
      def search_by_name names
        
      end
    end
  end
end