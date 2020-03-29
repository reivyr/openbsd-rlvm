# openbsd-rlvm

Patch to run rlvm to play some RealLive's visual novels on OpenBSD!


Download the script `openbsd-rlvm-sdl2.sh`. Please read the content before execute it in your machine. I use a [sdl2 fork of rlvm](https://github.com/FWGS/rlvm) by [a1batross](https://github.com/a1batross) but you can use the original [rlvm repository](https://github.com/eglaysher/rlvm) (currently it uses sdl and has more dependencies) by [eglaysher](https://github.com/eglaysher) with the script `openbsd-rlvm-sdl.sh`.


`ftp https://raw.githubusercontent.com/reivyr/openbsd-rlvm/master/openbsd-rlvm-sdl2.sh`


`sh openbsd-rlvm-sdl2.sh`


**You can use the binary `rlvm` located in the `build` directory of `rlvm-sdl2`**


`./rlvm --font /path-to-font /path-to-game-directory`


Remember that you need to provide a font, I included `vlgothic` as a dependency in the script because it fits better with Planetarian but you are free to try other fonts. Using vlgothic as a font:


`./rlvm --font /usr/local/share/fonts/vlgothic/VL-Gothic-Regular.ttf /path-to the-game-directory`


The game directory is the directory that contains `Seen.txt`.


## Playing games

I only played [CLANNAD](https://store.steampowered.com/app/324160/) and [Planetarian](https://store.steampowered.com/app/316720/). A detailed list of games can be found [here](https://github.com/eglaysher/rlvm/blob/master/STATUS.TXT). A notable difference that I found was that I can use the Dangopedia on CLANNAD and I can't use the in-game menu (right click) in Planetarian(in the sdl version it crashes the game and in the sdl2 version it does nothing) so you need to close the window in Planetarian to exit the game (don't forget to save your progress before that). Please read the **Additional notes** section for other details.


These two games are on steam and you can use `depotdownloader` from packages. Please read `/usr/local/share/doc/pkg-readmes/depotdownloader` and its [repository](https://github.com/SteamRE/DepotDownloader).


For the English content of [CLANNAD](https://steamdb.info/app/324160/depots/) you need to download [depot 324161](https://steamdb.info/depot/324161/) and for [Planetarian](https://steamdb.info/app/316720/depots/) is [depot 316721](https://steamdb.info/depot/316721/).


**Be careful with the versions of the games mentioned because there are many (for example [Planetarian HD](https://store.steampowered.com/app/623080) works with Siglus which is the successor of RealLive and its not included in this repository). You can use [The Visual Novel Database](https://vndb.org/) to search about the different editions of visual novels in general.**


## Additional notes

I tested both versions (sdl, sdl2) of rlvm and there were some segfaults related to `sdl_music` and `nwatowav`. As I don't know how to reproduce them consistently and fix them properly I put the diff `rlvm-sdlN-additional.diff` for both versions because with that at least I don't find these issues for now.


For the sdl version I rarely had segfaults related to the graphics system (again, I don't know how to reproduce them consistently).


**In spite of the aforementioned problems, I was able to finish Nagisa's route on CLANNAD.**


For the sdl2 version I included in the patch the commits [975e740c7342a2a13e12615db49f6145ab0bbce2](https://github.com/eglaysher/rlvm/commit/975e740c7342a2a13e12615db49f6145ab0bbce2) and [4c3a6ab18739b339f19b461691d99e21cb8a3d7b](https://github.com/eglaysher/rlvm/commit/4c3a6ab18739b339f19b461691d99e21cb8a3d7b) of the main repository. Other important note is that I use their `sdl2-mixer` and not the package form OpenBSD because I don't have sound on BGM (Background Music) in the games, but I included `sdl2-mixer` as a dependency in the script because I may need some dependencies that are installed with the package.


I don't build the tests with these patches but you can try it. I tested them (with the exception of luarlvm) before and all of these tests pass with one exception which was reported [here](https://github.com/eglaysher/rlvm/issues/66).


Some of these patches on this repository were based on the [FreeBSD port of rlvm](https://svnweb.freebsd.org/ports/head/devel/rlvm/files/?pathrev=478836).


Personally, I use the sdl2 fork and I see that these changes are in this [pull request](https://github.com/eglaysher/rlvm/pull/86) to the main repository.

