# bleUX, a user-centric desktop Linux distribution
# Copyright (C) 2026  Natan Junges <natanajunges@gmail.com>
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

aa_unconfined() {
    profile="$(echo "${1#/}" | tr / .)"

    if [ -f "/usr/apparmor.d/$profile" ] && ! grep -qm 1 'flags=(' "/usr/apparmor.d/$profile"; then
        sudo sed -Ei 's/profile([^{]+)\{/profile\1flags=(unconfined) {/' "/usr/apparmor.d/$profile"
        sudo apparmor_parser -r "/usr/apparmor.d/$profile"
    fi
}

case "$1" in
    disable)
        if ! dpkg-query -f '${db:Status-abbrev}' -W apparmor-utils 2> /dev/null | grep -q '^.i'; then
            echo 'The \e[1mapparmor-extras\e[0m feature is not enabled.' >&2
            exit 1
        fi

        sudo aa-complain /usr/bin/irssi /usr/sbin/sssd Xorg Xorg_wrap
        aa_unconfined 1password
        aa_unconfined Discord
        aa_unconfined 'MongoDB Compass'
        aa_unconfined QtWebEngineProcess
        aa_unconfined balena-etcher
        aa_unconfined brave
        aa_unconfined buildah
        aa_unconfined cam
        aa_unconfined ch-checkns
        aa_unconfined ch-run
        aa_unconfined chrome
        aa_unconfined chromium
        aa_unconfined crun
        aa_unconfined desktop-icons-ng
        aa_unconfined devhelp
        aa_unconfined element-desktop
        aa_unconfined epiphany
        aa_unconfined evolution
        aa_unconfined firefox
        aa_unconfined foliate
        aa_unconfined geary
        aa_unconfined github-desktop
        aa_unconfined goldendict
        aa_unconfined kchmviewer
        aa_unconfined keybase
        aa_unconfined lc-compliance
        aa_unconfined libcamerify
        aa_unconfined linux-sandbox
        aa_unconfined loupe
        aa_unconfined lxc-attach
        aa_unconfined lxc-create
        aa_unconfined lxc-destroy
        aa_unconfined lxc-execute
        aa_unconfined lxc-stop
        aa_unconfined lxc-unshare
        aa_unconfined lxc-usernsexec
        aa_unconfined mmdebstrap
        aa_unconfined msedge
        aa_unconfined notepadqq
        aa_unconfined obsidian
        aa_unconfined opam
        aa_unconfined opera
        aa_unconfined pageedit
        aa_unconfined podman
        aa_unconfined polypane
        aa_unconfined privacybrowser
        aa_unconfined qcam
        aa_unconfined qmapshack
        aa_unconfined qutebrowser
        aa_unconfined rootlesskit
        aa_unconfined rpm
        aa_unconfined rssguard
        aa_unconfined runc
        aa_unconfined scide
        aa_unconfined signal-desktop
        aa_unconfined slack
        aa_unconfined slirp4netns
        aa_unconfined steam
        aa_unconfined stress-ng
        aa_unconfined surfshark
        aa_unconfined systemd-coredump
        aa_unconfined thunderbird
        aa_unconfined trinity
        aa_unconfined tup
        aa_unconfined tuxedo-control-center
        aa_unconfined userbindmount
        aa_unconfined uwsgi-core
        aa_unconfined vdens
        aa_unconfined virtiofsd
        aa_unconfined vivaldi-bin
        aa_unconfined vpnns
        aa_unconfined vscode
        aa_unconfined wike
        aa_unconfined wpcom
    ;;
    enable)
        if ! dpkg-query -f '${db:Status-abbrev}' -W apparmor-utils 2> /dev/null | grep -q '^.i'; then
            echo 'The \e[1mapparmor-extras\e[0m feature is not enabled.' >&2
            exit 1
        fi

        sudo aa-enforce /usr/bin/irssi /usr/sbin/sssd Xorg Xorg_wrap 1password Discord 'MongoDB Compass' QtWebEngineProcess balena-etcher brave buildah cam ch-checkns ch-run chrome chromium crun desktop-icons-ng devhelp element-desktop epiphany evolution firefox foliate geary github-desktop goldendict kchmviewer keybase lc-compliance libcamerify linux-sandbox loupe lxc-attach lxc-create lxc-destroy lxc-execute lxc-stop lxc-unshare lxc-usernsexec mmdebstrap msedge notepadqq obsidian opam opera pageedit podman polypane privacybrowser qcam qmapshack qutebrowser rootlesskit rpm rssguard runc scide signal-desktop slack slirp4netns steam stress-ng surfshark systemd-coredump thunderbird trinity tup tuxedo-control-center userbindmount uwsgi-core vdens virtiofsd vivaldi-bin vpnns vscode wike wpcom
    ;;
    *)
        echo Unknown feature subcommand. >&2
        exit 1
    ;;
esac
