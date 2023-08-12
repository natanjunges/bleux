# bleUX OS - Ubuntu Edition
An Ubuntu-based user-centric desktop Linux distribution

- Based on Ubuntu Desktop 22.04 LTS, built with [Cubic](https://github.com/PJ-Singh-001/Cubic);
- Gnome DE (other DEs are not supported);
- Modularly enable/disable core features using scripts:

| Feature    | Enabled by default       | Command to enable   | Command to disable     |
|:-----------|:------------------------:|:--------------------|:-----------------------|
| apt        | <ul><li>- [ ] </li></ul> | `sudo apt-enable`   | `sudo apt-disable`     |
| flatpak    | <ul><li>- [x] </li></ul> | `sudo flatpak-add`  | `sudo flatpak-remove`  |
| nala       | <ul><li>- [x] </li></ul> | `sudo nala-add`     | `sudo nala-remove`     |
| pipewire   | <ul><li>- [x] </li></ul> | `sudo pipewire-add` | `sudo pipewire-remove` |
| pulseaudio | <ul><li>- [ ] </li></ul> |                     |                        |
| snap       | <ul><li>- [ ] </li></ul> | `sudo snap-add`     | `sudo snap-remove`     |
