# bleUX, a user-centric desktop Linux distribution
# Copyright (C) 2023, 2024  Natan Junges <natanajunges@gmail.com>
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
        rm /etc/apt/preferences.d/nosnap.pref
        apt-get install -y --mark-auto snapd
        snap install snapd

        if dpkg-query -f '${db:Status-abbrev}' -W gnome-software 2> /dev/null | grep -q '^.i'; then
            apt-get install -y --mark-auto gnome-software-plugin-snap
        fi
    ;;
    remove)
        apt-get purge -y snapd gnome-software-plugin-snap
        ln -s /usr/lib/bleux-features/nosnap.pref /etc/apt/preferences.d/
    ;;
    *)
        exit 37
    ;;
esac
