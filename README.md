# 2HOLCompile

 Minimal scripts to compile 2HOL client, server and editor

## TLDR Usage

Get WSL (Windows Subsystem for Linux) by enabling it in "Apps & features", and then in the WSL shell run the line below to compile and start the game client:

```bash
./buildFromScratch.sh
```

## Compiling (and running) the Server

```bash
./cleanOldBuildsAndCaches.sh
./server.sh
```

## Compiling the Editor

```bash
./cleanOldBuildsAndCaches.sh
./getEditorDependencies.sh
./editor.sh
```

## Quick Recompiling the Game Client

After you made changes to the client code, just run this, and it will start the new client as well:

```bash
./compile.sh
```

## Start Server (Without Recompiling)

```bash
./runServer.sh
```

## More Info

This is meant to be minimal, if you want more info:

[Defalt's TwoLifeXcompile](https://github.com/Defalt36/TwoLifeXcompile)

[OneLifeXcompile](https://github.com/Joriom/OneLifeXcompile) (where the makefile in this repo for cross-compiling for Windows on Linux came from)

[Jason's compiling note](http://onehouronelife.com/compileNotes.php?nocounter=1)

[Note on cross-compiling the editor](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/devProcess/mingwNotes.txt)

[Note on compiling the editor and server](https://github.com/jasonrohrer/OneLife/blob/dba27afbcee804026962f9fae319540f45fd6e42/documentation/EditorAndServerBuildNotes.txt)

[Some old scripts to compile 2HOL](https://github.com/twohoursonelife/2HOL)

[Hetuw's compile scripts](https://github.com/hetuw/OneLife/tree/master/scripts/hetuwScripts)
