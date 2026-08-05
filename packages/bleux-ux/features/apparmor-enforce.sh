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

aa-unconfine() {
    profile="$(echo "${1#/}" | tr / .)"

    if [ -f "/usr/apparmor.d/$profile" ] && ! grep -qm 1 'flags=(' "/usr/apparmor.d/$profile"; then
        sudo sed -Ei 's/profile([^{]+)\{/profile\1flags=(unconfined) {/' "/usr/apparmor.d/$profile"
        sudo apparmor_parser -r "/usr/apparmor.d/$profile"
    fi
}

case "$1" in
    disable)
        sudo aa-complain /usr/bin/irssi /usr/sbin/sssd Xorg Xorg_wrap
        aa-unconfine 1password
        aa-unconfine Discord
        aa-unconfine 'MongoDB Compass'
        aa-unconfine QtWebEngineProcess
        aa-unconfine balena-etcher
        aa-unconfine brave
        aa-unconfine buildah
        aa-unconfine cam
        aa-unconfine ch-checkns
        aa-unconfine ch-run
        aa-unconfine chrome
        aa-unconfine chromium
        aa-unconfine crun
        aa-unconfine desktop-icons-ng
        aa-unconfine devhelp
        aa-unconfine element-desktop
        aa-unconfine epiphany
        aa-unconfine evolution
        aa-unconfine firefox
        aa-unconfine foliate
        aa-unconfine geary
        aa-unconfine github-desktop
        aa-unconfine goldendict
        aa-unconfine kchmviewer
        aa-unconfine keybase
        aa-unconfine lc-compliance
        aa-unconfine libcamerify
        aa-unconfine linux-sandbox
        aa-unconfine loupe
        aa-unconfine lxc-attach
        aa-unconfine lxc-create
        aa-unconfine lxc-destroy
        aa-unconfine lxc-execute
        aa-unconfine lxc-stop
        aa-unconfine lxc-unshare
        aa-unconfine lxc-usernsexec
        aa-unconfine mmdebstrap
        aa-unconfine msedge
        aa-unconfine notepadqq
        aa-unconfine obsidian
        aa-unconfine opam
        aa-unconfine opera
        aa-unconfine pageedit
        aa-unconfine podman
        aa-unconfine polypane
        aa-unconfine privacybrowser
        aa-unconfine qcam
        aa-unconfine qmapshack
        aa-unconfine qutebrowser
        aa-unconfine rootlesskit
        aa-unconfine rpm
        aa-unconfine rssguard
        aa-unconfine runc
        aa-unconfine scide
        aa-unconfine signal-desktop
        aa-unconfine slack
        aa-unconfine slirp4netns
        aa-unconfine steam
        aa-unconfine stress-ng
        aa-unconfine surfshark
        aa-unconfine systemd-coredump
        aa-unconfine thunderbird
        aa-unconfine trinity
        aa-unconfine tup
        aa-unconfine tuxedo-control-center
        aa-unconfine userbindmount
        aa-unconfine uwsgi-core
        aa-unconfine vdens
        aa-unconfine virtiofsd
        aa-unconfine vivaldi-bin
        aa-unconfine vpnns
        aa-unconfine vscode
        aa-unconfine wike
        aa-unconfine wpcom
    ;;
    enable)
        sudo aa-enforce /usr/bin/irssi /usr/sbin/sssd Xorg Xorg_wrap 1password Discord 'MongoDB Compass' QtWebEngineProcess balena-etcher brave buildah cam ch-checkns ch-run chrome chromium crun desktop-icons-ng devhelp element-desktop epiphany evolution firefox foliate geary github-desktop goldendict kchmviewer keybase lc-compliance libcamerify linux-sandbox loupe lxc-attach lxc-create lxc-destroy lxc-execute lxc-stop lxc-unshare lxc-usernsexec mmdebstrap msedge notepadqq obsidian opam opera pageedit podman polypane privacybrowser qcam qmapshack qutebrowser rootlesskit rpm rssguard runc scide signal-desktop slack slirp4netns steam stress-ng surfshark systemd-coredump thunderbird trinity tup tuxedo-control-center userbindmount uwsgi-core vdens virtiofsd vivaldi-bin vpnns vscode wike wpcom
    ;;
    *)
        echo Unknown feature subcommand. >&2
        exit 1
    ;;
esac
