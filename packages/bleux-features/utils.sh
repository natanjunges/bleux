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

die() {
    echo $@ >&2
    exit 1
}

die_subcommand() {
    die 'Unknown subcommand.'
}

die_feature() {
    die 'The\e[1m' $1 '\e[0mfeature is not enabled.'
}

die_flatpak() {
    die_feature flatpak
}

die_snap() {
    die_feature snap
}

check_package() {
    if dpkg-query -f '${db:Status-abbrev}' -W $1 2> /dev/null | grep -q '^.i'; then
        echo 1
    fi
}

check_gnome_software() {
    check_package gnome-software
}

check_flatpak() {
    check_package flatpak
}

check_snap() {
    check_package snapd
}

apt_get_install() {
    apt-get install -y --mark-auto $@
}

apt_get_purge() {
    apt-get purge -y $@
}

flatpak_install() {
    flatpak install -y --noninteractive --no-related $1
}

flatpak_remove() {
    flatpak remove -y --noninteractive $1
}

snap_install() {
    snap install $1
}

snap_purge() {
    snap remove --purge $1
}

feature() {
    subcommand="$1"
    has_feature="$2"
    die_command=$3
    add_command=$4
    remove_command=$5
    shift
    shift
    shift
    shift
    shift

    case "$subcommand" in
        add)
            if [ -z "$has_feature" ]; then
                $die_command
            fi

            $add_command $@
        ;;
        remove)
            if [ -z "$has_feature" ]; then
                exit 0
            fi

            $remove_command $@
        ;;
        *)
            die_subcommand
        ;;
    esac
}

feature_deb() {
    subcommand="$1"
    shift
    feature "$subcommand" 1 '' apt_get_install apt_get_purge $@
}

feature_flatpak() {
    feature "$1" "$(check_flatpak)" die_flatpak flatpak_install flatpak_remove $2
}

feature_snap() {
    feature "$1" "$(check_snap)" die_snap snap_install snap_purge $2
}
