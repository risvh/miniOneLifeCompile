#!/bin/bash

cmd.exe /c "mklink $1 ${2//\//\\\\} ${3//\//\\\\}"