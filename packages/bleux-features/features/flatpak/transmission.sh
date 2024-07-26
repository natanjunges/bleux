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

if ! dpkg-query -f '${db:Status-abbrev}' -W flatpak 2> /dev/null | grep -q '^.i'; then
    no_flatpak=1
fi

case $1 in
    add)
        if [ $no_flatpak ]; then
            echo 'The \e[1mflatpak\e[0m feature is not enabled.' >&2
            exit 1
        fi

        flatpak install -y --noninteractive --no-related com.transmissionbt.Transmission
    ;;
    remove)
        if [ $no_flatpak ]; then
            exit 0
        fi

        flatpak remove -y --noninteractive --system com.transmissionbt.Transmission
    ;;
    *)
        exit 37
    ;;
esac
