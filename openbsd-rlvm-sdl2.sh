#!/bin/sh

set -e

DEP=$(pkg_info -z | grep -E '^(scons|gettext-tools|sdl2|sdl2-ttf|sdl2-image|sdl2-mixer|vlgothic)\-\-' | wc -l)

if [ "$DEP" -eq 7 ]
then
	echo "Dependencies installed"
else
	echo "Dependencies missing. Required packages are scons, gettext-tools, sdl2, sdl2-ttf, sdl2-image, sdl2-mixer, vlgothic"
	exit 1
fi

# Download the repository from FWGS

git clone https://github.com/FWGS/rlvm rlvm-sdl2
cd rlvm-sdl2
git checkout 14530d76b2a870ebc320386a35c170716203a090

# Download the diff from my repository

ftp https://raw.githubusercontent.com/reivyr/openbsd-rlvm/master/patches/sdl2/rlvm-sdl2-openbsd.diff \
https://raw.githubusercontent.com/reivyr/openbsd-rlvm/master/patches/sdl2/rlvm-sdl2-additional.diff

# Apply with patch(1)

patch -p0 < rlvm-sdl2-openbsd.diff
patch -p0 < rlvm-sdl2-additional.diff

# Run scons

scons --release

# Final Message

echo "You can use rlvm in the build directory of rlvm-sdl2:"
echo "cd rlvm-sdl2/build"
echo "./rlvm --font /path-to-font /path-to-game-directory"
echo "You can use /usr/local/share/fonts/vlgothic/VL-Gothic-Regular.ttf as a font"
echo "but you can try other fonts of your preference. I choose that because"
echo "it fits better with Planetarian."
