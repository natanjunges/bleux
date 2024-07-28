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

. /usr/lib/bleux-features/utils.sh

has_flatpak="$(check_flatpak)"

case "$1" in
    add)
        if [ -z "$has_flatpak" ]; then
            die_flatpak
        fi

        flatpak_install org.mozilla.Thunderbird
        flatpak override --nosocket=x11 org.mozilla.Thunderbird
    ;;
    remove)
        if [ -z "$has_flatpak" ]; then
            exit 0
        fi

        flatpak_remove org.mozilla.Thunderbird
    ;;
    *)
        die_subcommand
    ;;
esac
