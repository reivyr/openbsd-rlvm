#!/bin/sh

set -e

DEP=$(pkg_info -z | grep -E '^(scons|sdl|sdl-ttf|sdl-image|sdl-mixer|vlgothic)\-\-' | wc -l)

if [ "$DEP" -eq 6 ]
then
	echo "Dependencies installed"
else
	echo "Dependencies missing. Required packages are scons, sdl, sdl-ttf, sdl-image, sdl-mixer, vlgothic"
	exit 1
fi

# Download the repository from FWGS

git clone https://github.com/eglaysher/rlvm rlvm-sdl
cd rlvm-sdl
git checkout 975e740c7342a2a13e12615db49f6145ab0bbce2

# Download the diff from my repository

ftp https://raw.githubusercontent.com/reivyr/openbsd-rlvm/master/patches/sdl/rlvm-sdl-openbsd.diff \
https://raw.githubusercontent.com/reivyr/openbsd-rlvm/master/patches/sdl/rlvm-sdl-additional.diff

# Apply with patch(1)

patch -p0 < rlvm-sdl-openbsd.diff
patch -p0 < rlvm-sdl-additional.diff

# Run scons

scons --release

# Final Message

echo "You can use rlvm in the build directory of rlvm-sdl:"
echo "cd build"
echo "./rlvm --font /path-to-font /path-to-game-directory"
echo "You can use /usr/local/share/fonts/vlgothic/VL-Gothic-Regular.ttf as a font"
echo "but you can try other fonts of your preference. I choose that because"
echo "it fits better with Planetarian."
