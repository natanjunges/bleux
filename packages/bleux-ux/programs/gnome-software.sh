# bleUX, a user-centric desktop Linux distribution
# Copyright (C) 2024, 2026  Natan Junges <natanajunges@gmail.com>
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

sudo_keepalive() {
    while true; do
        sleep 14m
        sudo -v
    done
}
kill_sudo() {
    kill $sudo_keepalive_pid
}
validate_sudo() {
    trap kill_sudo EXIT
    sudo -v
    sudo_keepalive &
    sudo_keepalive_pid=$!
}

case "$1" in
    add)
        validate_sudo
        sudo apt-get install -y --mark-auto gnome-software

        if dpkg-query -f '${db:Status-abbrev}' -W flatpak 2> /dev/null | grep -q '^.i'; then
            sudo apt-get install -y --mark-auto gnome-software-plugin-flatpak
        fi

        if dpkg-query -f '${db:Status-abbrev}' -W snapd 2> /dev/null | grep -q '^.i'; then
            sudo apt-get install -y --mark-auto gnome-software-plugin-snap
        fi
    ;;
    remove)
        sudo apt-get purge -y gnome-software gnome-software-plugin-flatpak gnome-software-plugin-snap
    ;;
    *)
        echo Unknown program subcommand. >&2
        exit 1
    ;;
esac
