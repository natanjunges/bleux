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

. /usr/lib/bleux-features/utils.sh

case "$1" in
    add)
        apt_get_install flatpak
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

        if [ "$(check_gnome_software)" ]; then
            apt_get_install gnome-software-plugin-flatpak
        fi
    ;;
    remove)
        flatpak remove -y --all
        apt_get_purge flatpak gnome-software-plugin-flatpak
    ;;
    update)
        flatpak update -y --noninteractive --system
    ;;
    remove-unused)
        flatpak remove -y --noninteractive --system --unused
    ;;
    *)
        die_subcommand
    ;;
esac
