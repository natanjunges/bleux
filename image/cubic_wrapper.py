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
import os
import time
import threading
import pexpect

import gi
gi.require_version("GLib", "2.0")
from gi.repository import GLib

sys.path.append("/usr/share/cubic")
PAGE = os.environ["PAGE"]
HEADLESS = len(os.environ.get("HEADLESS", "")) > 0
FPS = 60

def navigate():
    from cubic import navigator
    from cubic.utilities import model

    # Wait for initialization to complete
    while model.builder is None or model.builder.get_object("next_button") is None:
        time.sleep(1/FPS)

    next_button = model.builder.get_object("next_button")

    # Wait for start_page to complete
    while not next_button.is_sensitive():
        time.sleep(1/FPS)

    wait_gui()
    next_button.emit("clicked")
    pages = model.builder.get_object("pages")
    wait_page(pages, navigator, "project_page")
    next_button.emit("clicked")

    if PAGE == "chroot":
        command = f"clear; UPGRADE={os.environ['UPGRADE']} ./customize; exit\n"
    else:
        command = "exit\n"

    from cubic.pages import terminal_page

    # Wait for terminal_page to load
    while not terminal_page.is_running:
        time.sleep(1/FPS)

    wait_gui()
    terminal_page.console.reenter = False
    terminal_page.terminal.feed_child(bytes(command, encoding="UTF-8"))
    last_position = (0, 0)

    # Wait for terminal_page to complete
    while terminal_page.is_running:
        current_position = terminal_page.terminal.get_cursor_position()

        if last_position[1] != current_position[1] or current_position[0] != 0:
            print("\r", end="")
            print(terminal_page.terminal.get_text_range(last_position[1], 0, current_position[1], current_position[0])[0], end="")
            last_position = current_position

        time.sleep(1/FPS)

    wait_gui()

    if PAGE == "chroot":
        next_button.emit("clicked")
        wait_page(pages, navigator, "prepare_page")
        next_button.emit("clicked")
        wait_page(pages, navigator, "options_page")
        next_button.emit("clicked")
        wait_page(pages, navigator, "compression_page")
        next_button.emit("clicked")
        wait_page(pages, navigator, "generate_page")

    model.builder.get_object("window").destroy()

def wait_page(pages, navigator, page):
    # Wait for page to become visible
    while pages.get_visible_child_name() != page:
        time.sleep(1/FPS)

    navigator.navigation_thread.join()
    wait_gui()

def wait_gui():
    barrier = threading.Barrier(2)
    GLib.idle_add(gui_done, barrier, priority=GLib.PRIORITY_LOW)
    barrier.wait()

def gui_done(barrier):
    barrier.wait()

if HEADLESS:
    display_name = f"wayland-{os.getpid()}"
    os.environ["WAYLAND_DISPLAY"] = display_name
    headless_display = pexpect.spawn(f"weston --no-config --backend=headless-backend.so --socket={display_name}")
    headless_display.expect("Output '[^']+' enabled with head\\(s\\) headless")

try:
    threading.Thread(target=navigate, daemon=True).start()

    import cubic_wizard
except Exception as e:
    print(e)
finally:
    if HEADLESS:
        headless_display.close()
