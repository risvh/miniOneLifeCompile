# miniOneLifeCompile

Minimal scripts to compile 2HOL/OHOL client, server and editor

## TLDR usage

Get WSL (Windows Subsystem for Linux) by enabling it in Windows' "Apps & features".

In the WSL shell run the line below to compile and start the game client:

```bash
./buildFromScratch.sh
```

## To compile the Server:

```bash
./cleanOldBuildsAndCaches.sh
./server.sh
```

## To compile the Editor:

```bash
./cleanOldBuildsAndCaches.sh
./getEditorDependencies.sh
./editor.sh
```

## To recompile the game after code change:

```bash
./compile.sh
```

## To start the Server (without recompiling):

```bash
./runServer.sh
```

## To compile 2HOL Hetuw:

```bash
./cleanOldBuildsAndCaches.sh
./repo/checkoutDifferentRepo.sh tholHetuw
./applyFixesAndOverride.sh
./compile.sh
```

For other build targets, do `./checkoutDifferentRepo.sh` without argument to get the list of options.

## To compile for other platforms:

The scripts cross-compile the client and editor for Windows on Linux, and compile the server for Linux by default.  
(Remember to `./cleanOldBuildsAndCaches.sh` before compiling every time you switch between for different platforms.)

To compile the client and editor for Linux:  
Either specify platform with 1 as below, or change the number in PLATFORM_OVERRIDE to 1 to make compiling default to Linux.  
(Note: running graphical apps on WSL requires additional third-party apps, e.g. Xming, to work)

```bash
./cleanOldBuildsAndCaches.sh
./compile.sh 1
```

```bash
./cleanOldBuildsAndCaches.sh
./editor.sh 1
```

To cross-compile the server for Windows on Linux:

```bash
./cleanOldBuildsAndCaches.sh
./server.sh 5
```

## Note 

The scripts expect folder structure as below, you may want to clone this repo within a root folder:
```
root/
├── miniOneLifeCompile/
├── OneLife/
├── OneLifeData7/
├── minorGems/
└── output/
```

Run all the scripts from `root/miniOneLifeCompile/`. If you are running the scripts on WSL, you should not place the root folder in a WSL directory; instead put it in a Windows directory, and fire a WSL shell within that directory.

## What do all these scripts do?

`./applyFixesAndOverride.sh`  
Fix a few things that prevent cross-compiling, run this whenever you have a fresh clone of repos or whenever you reset.

`./buildFromScratch.sh`  
Build the game from scratch. It is only for demonstration purpose.

`./cleanOldBuildsAndOptionallyCaches.sh` `[1: clear cache]`  
Remove previous build files. Must run this before switching to compile for a different platform.

`./cloneRepos.sh`  
Clone the 3 repos - OneLife, OneLifeData7 and minorGems if they don't exist yet.

`./compile.sh` `[1: for Linux | 5: for Windows (default)]`  
Compile and then run the game.

`./editor.sh` `[1: for Linux | 5: for Windows (default)]`  
Compile the editor.

`./getDependencies.sh`  
Get the dependencies required by the game.

`./getEditorDependencies.sh`  
Get the dependencies required by the editor.

`./makeFullGameFolder.sh`  
Copy the game assets into the output folder. You don't need to run this unless you want a full copy of the files. The scripts by default make symlinks/shortcuts instead.

`PLATFORM_OVERRIDE`  
Override the platform defaults. The scripts by default compile the game and editor for Windows and server for Linux. Put 1 inside for Linux or 5 for Windows if you're not happy about the defaults but too lazy to type the alternative number.

`./runServer.sh`  
Start the server.

`./server.sh` `[1: for Linux (default) | 5: for Windows]`  
Compile and start the server.

`./util/changeEOL.sh`  
Change the EOL of the scripts in this repo to Unix style. Helpful if you clone this repo with a Windows software but gonna run them on WSL.

`./util/createSymLinks.sh`  
Used by other scripts to create symlinks or Windows shortcuts.

`./util/mklink.sh`  
Used by other scripts to create Windows shortcuts.

---

There are some git scripts in the `./repo/` folder to help the dev process. It is not the purpose of this repo to git-manage. ***These scripts are not polished and could be dangerous to use. Please read them before running.***

My use case: I use Github Desktop to manage my repos. I want the different forks of say OneLife e.g. 2HOL OneLife, Hetuw OneLife etc to be remotes in the same folder. The scripts below try to keep Github Desktop from freaking out with this arrangement.

`./repo/addRemote.sh`  `[repo: OneLife / OneLifeData7 / minorGems] [remote] [remoteURL]`  
Add a remote and track all its branches.

`./repo/changeWhatToBuild.sh` `[build options]`  
Checkout different remotes of all 3 repos OneLife, OneLifeData7 and minorGems given what you wish to build. Leave the argument blank to see the options. For example, if you want to build 2HOL Hetuw, this script will change OneLife, OneLifeData7 and minorGems to the appropriate forks so they are compatible and so the game will compile. Script will add the forks as remotes if they do not exist.

`./repo/defineURLs.sh`  
Do `source ./repo/defineURLs.sh` so you don't need to type out the urls.

`./repo/emptyRepo.sh` `[repo]`  
Clear ALL the remotes and branches from a local repo.

`./repo/ensureClean.sh` `[repo: OneLife / OneLifeData7 / minorGems]`  
Check if the repos are clean, if not, prompt to reset them.

`./repo/newBranchOnThisRemote.sh`  `[repo] [remote] [newBranchName]`  
Create a new branch and publish it to the remote. Since Github Desktop seems to always publish new branches to origin...

`./repo/removeRemote.sh`  `[repo] [remote]`  
Remove a remote and all its local branches.

`./repo/testPullRequest.sh`  `[repo] [remote] [prNum]`  
Fetch and checkout a PR by its number as a new local branch.

`./repo/undoOverride.sh`  
Roughly undo `./applyFixesAndOverride.sh`. So those fixes won't appear on Github Desktop.


## More Info

This is meant to be minimal, if you want more info:

[Defalt's TwoLifeXcompile](https://github.com/Defalt36/TwoLifeXcompile)

[OneLifeXcompile](https://github.com/Joriom/OneLifeXcompile) (where the makefile in this repo for cross-compiling for Windows on Linux came from)

[Jason's compiling note](http://onehouronelife.com/compileNotes.php?nocounter=1)

[Note on cross-compiling the editor](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/devProcess/mingwNotes.txt)

[Note on compiling the editor and server](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/EditorAndServerBuildNotes.txt)

[Some old scripts to compile 2HOL](https://github.com/twohoursonelife/2HOL)

[Hetuw's compile scripts](https://github.com/hetuw/OneLife/tree/master/scripts/hetuwScripts)
