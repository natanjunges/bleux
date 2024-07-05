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

ln -s /usr/lib/bleux-features/fix-python3-typer.list /etc/apt/sources.list.d/
ln -s /usr/lib/bleux-features/fix-python3-typer.pref /etc/apt/preferences.d/
mv /etc/apt/sources.list.d/volian-archive-nala-unstable.sources.disabled /etc/apt/sources.list.d/volian-archive-nala-unstable.sources
apt-mark unhold volian-archive-nala
apt-get update --no-list-cleanup -o Dir::Etc::SourceList="sources.list.d/fix-python3-typer.list" -o Dir::Etc::SourceParts="-"
apt-get update --no-list-cleanup -o Dir::Etc::SourceList="sources.list.d/volian-archive-nala-unstable.sources" -o Dir::Etc::SourceParts="-"
apt-get install -y --mark-auto --no-install-recommends nala
