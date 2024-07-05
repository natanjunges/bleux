#!/usr/bin/python3

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

import sys
import time
import threading

sys.path.append("/usr/share/cubic")

FPS = 60

def navigate():
    from cubic.utilities import model

    # Wait for initialization to complete
    while model.builder is None or model.builder.get_object("next_button") is None:
        time.sleep(1/FPS)

    next_button = model.builder.get_object("next_button")

    # Wait for start_page to complete
    while not next_button.is_sensitive():
        time.sleep(1/FPS)

    next_button.emit("clicked")
    pages = model.builder.get_object("pages")

    # Wait for project_page to show
    while pages.get_visible_child_name() != "project_page":
        time.sleep(1/FPS)

    # Wait for project_page to complete
    while len(threading.enumerate()) > 2:
        time.sleep(1/FPS)

    next_button.emit("clicked")

    # Wait for extract_page to complete
    while not model.status.is_success_extract:
        time.sleep(1/FPS)

    model.builder.get_object("window").destroy()

threading.Thread(target=navigate, daemon=True).start()

import cubic_wizard
