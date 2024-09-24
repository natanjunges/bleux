# bleUX
A user-centric desktop Linux distribution

- Based on Ubuntu Desktop 22.04 LTS;
- Vanilla Gnome DE;
- Modularly enable/disable [core features](https://github.com/natanjunges/bleux/wiki/Features) using scripts;

## Installation
### Development

```shell
sudo apt-get install -y equivs git make
git clone https://github.com/natanjunges/bleux.git
cd bleux/repository
./build -j 6 install
cd ..
./customize
```

### Production

```shell
wget -q -O - https://raw.githubusercontent.com/natanjunges/bleux/main/customize | sh
```
