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

case $1 in
    add)
        apt-get install -y --mark-auto gnome-shell-extension-desktop-icons-ng
    ;;
    remove)
        apt-get purge -y gnome-shell-extension-desktop-icons-ng
    ;;
    *)
        exit 1
    ;;
esac