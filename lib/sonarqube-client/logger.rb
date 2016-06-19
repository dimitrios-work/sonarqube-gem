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
  class Logger
    
    def self.log(*args, level)
      @@logger=Logger.new *args
      @@logger.level loglevel level
    end
    
    def loglevel(level)
      case level
      when 'debug'
        return 0
      when 'info'
        return 1
      when 'warn'
        return 2
      when 'error'
        return 3
      when 'fatal'
        return 4
      else
      end
    end
  end
end
