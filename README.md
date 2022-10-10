# miniOneLifeCompile

Scripts to make 2HOL/OHOL client, server and editor.

## Usage

1. You need to enable WSL/WSL2, follow this tutorial until its 4th step. https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-10
2. Create a new folder, name it say Root, go into it, shift + right click on empty space then select "Open Linux shell here"
3. Copy and paste the following into the shell: `git clone https://github.com/risvh/miniOneLifeCompile.git miniOneLifeCompile` and hit Enter (That's how you run commands in WSL, the rest of the steps follow similarly.) If you see the error "git command not found", run `sudo apt-get update && sudo apt-get install -y git` first. (It may prompt you for the password you set up in step 1.)
4. Run `cd miniOneLifeCompile`, now you are at the miniOneLifeCompile folder in WSL, all the scripts in this repo expect you to be in this folder when you run them. Next time you can simply open the Linux shell in this miniOneLifeCompile folder.
5. Get the game dependencies `./getDependencies.sh`
6. Clone the other repositories `./cloneRepos.sh`
7. Run `./applyFixesAndOverride.sh`
8. Compile (meaning you make the software from the source code) the server `./server.sh` This will start the server as well, when the shell seems to stop running (you should see something like "Listening for connection on port 8005"), press ctrl+C in the shell to terminate the server for now, so you can continue the remaining steps.
9. Clear the previous build files before we compile for the game later `./cleanOldBuildsAndOptionallyCaches.sh`
10. Compile the game client `./compile.sh` Again this will start the game. Close the game and continue.
11. If you also need the editor, first get the dependencies `./getEditorDependencies.sh` then run  `./cleanOldBuildsAndOptionallyCaches.sh`, and then `./editor.sh`. Otherwise skip to step 12.
12. Now if you go back into the Root folder, or whatever name you gave it in step 2. Go into the output folder. You should see the game OneLife.exe, the server OneLifeServer and maybe the editor EditOneLife.exe if you did step 11.
13. Before you start the server, you need to sort out a few settings. Go into the output folder, then go into the settings folder. Open requireTicketServerCheck.ini with a text editor like Notepad, change the content to 0, save and exit. If you also need the admin tool to spawn items in your local server, change the content of vogAllowAccounts.ini to just an "*" (without the quote); also change vogModeOn.ini to 1.
13. In the shell, start the server `./runServer.sh`, keep the shell open to let the server run.
14. Double click OneLife.exe to start the game. Go into the Setting page in the game. Choose the GAMEPLAY tab on the left, check the box "USE CUSTOM SERVER", put "localhost" in the ADDRESS field, and "8005" in the PORT field. Click back to get back to the Login page.
15. Now you can click PLAY to connect to your local server and play.

If you're stuck, you can join the 2HOL discord and ask for help there:) https://discord.gg/Jd9Es3f


## Note 

The scripts expect folder structure as below, you may want to clone this repo within a root folder:
```
Root/
├── miniOneLifeCompile/
├── OneLife/
├── OneLifeData7/
├── minorGems/
└── output/
```

The scripts in this repo all expect you to be in the miniOneLifeCompile folder when you run them. Also, if you are running the scripts on WSL, you should not place the Root folder in a WSL directory; instead put it in a Windows directory, and fire a WSL shell within that folder (Shift-right click in that folder, then select "Open Linux shell here").

## What do all these scripts do?

`./applyFixesAndOverride.sh`  
Fix a few things that bug out when cross-compiling, run this whenever you have a fresh clone of repos or whenever you reset.

`./cleanOldBuildsAndOptionallyCaches.sh` `[1: clear cache]`  
Remove previous build files. Must run this before switching between compiling for different platforms.

`./cloneRepos.sh`  
Clone the 3 repos - OneLife, OneLifeData7 and minorGems if they don't exist yet.

`./compile.sh` `[1: for Linux | 5: for Windows (default)]`  
Compile and run the game.

`./editor.sh` `[1: for Linux | 5: for Windows (default)]`  
Compile the editor.

`./getDependencies.sh`  
Get the dependencies required by the game.

`./getEditorDependencies.sh`  
Get the dependencies required by the editor.

`PLATFORM_OVERRIDE`  
Override the platform defaults. The scripts by default compile the game and editor for Windows and server for Linux. Put 1 inside this file for Linux or 5 for Windows if you're not happy about the defaults but too lazy to type the alternative number.

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

There are some git scripts in the `./repo/` folder to help the dev process. It is not the purpose of this repo to git-manage. ***These scripts are not polished and could be dangerous to use. Please read these scripts before running.***

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

`./repo/makeFullGameFolderForRelease.sh.sh` `[1: for Linux | 5: for Windows (default)]`
Do a full copy of the game asset folders and the game to make a complete game folder ready for release, or for diffBundle to create the patches for autoupdate.

`./repo/newBranchOnThisRemote.sh`  `[repo] [remote] [newBranchName]`  
Create a new branch and publish it to the remote. Since Github Desktop seems to always publish new branches to origin...

`./repo/removeRemote.sh`  `[repo] [remote]`  
Remove a remote and all its local branches.

`./repo/testPullRequest.sh`  `[repo] [remote] [prNum]`  
Fetch and checkout a PR by its number as a new local branch.

`./repo/undoOverride.sh`  
Roughly undo `./applyFixesAndOverride.sh`. So those fixes won't appear on Github Desktop.


## More Info

More information on the how to compile this game:

[Defalt's TwoLifeXcompile](https://github.com/Defalt36/TwoLifeXcompile)

[OneLifeXcompile](https://github.com/Joriom/OneLifeXcompile) (where the makefile in this repo for cross-compiling for Windows on Linux came from)

[Jason's compiling note](http://onehouronelife.com/compileNotes.php?nocounter=1)

[Note on cross-compiling the editor](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/devProcess/mingwNotes.txt)

[Note on compiling the editor and server](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/EditorAndServerBuildNotes.txt)

[Some old scripts to compile 2HOL](https://github.com/twohoursonelife/2HOL)

[Hetuw's compile scripts](https://github.com/hetuw/OneLife/tree/master/scripts/hetuwScripts)
