# bleUX, a user-centric desktop Linux distribution
# Copyright (C) 2024  Natan Junges <natanajunges@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

case "$1" in
    add)
        apt-get install -y --mark-auto gnome-software gnome-software-plugin-snap-

        if dpkg-query -f '${db:Status-abbrev}' -W flatpak 2> /dev/null | grep -q '^.i'; then
            apt-get install -y --mark-auto gnome-software-plugin-flatpak
        fi

        if dpkg-query -f '${db:Status-abbrev}' -W snapd 2> /dev/null | grep -q '^.i'; then
            apt-get install -y --mark-auto gnome-software-plugin-snap
        fi
    ;;
    remove)
        apt-get purge -y gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap
    ;;
    *)
        exit 37
    ;;
esac
