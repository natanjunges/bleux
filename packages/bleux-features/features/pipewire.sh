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
        apt-get install -y --mark-auto pipewire-audio-client-libraries wireplumber libspa-0.2-bluetooth libspa-0.2-jack
        apt-get purge -y pipewire-media-session
        ln -s /usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/
        ln -s /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
        ldconfig
    ;;
    remove)
        rm /etc/alsa/conf.d/99-pipewire-default.conf /etc/ld.so.conf.d/pipewire-jack-*.conf
        ldconfig
        apt-get install -y --mark-auto pipewire-media-session
        apt-get purge -y pipewire-audio-client-libraries wireplumber libspa-0.2-bluetooth libspa-0.2-jack
    ;;
    *)
        exit 37
    ;;
esac
