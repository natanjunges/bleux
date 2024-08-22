# bleUX, a user-centric desktop Linux distribution
# Copyright (C) 2024  Natan Junges <natanajunges@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

set -e

. /usr/lib/bleux-features/utils.sh

case "$1" in
    add)
        apt_get_install gnome-software gnome-software-plugin-snap-

        if [ "$(check_flatpak)" ]; then
            apt_get_install gnome-software-plugin-flatpak
        fi

        if [ "$(check_snap)" ]; then
            apt_get_install gnome-software-plugin-snap
        fi
    ;;
    remove)
        apt_get_purge gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap
    ;;
    *)
        die_subcommand
    ;;
esac
