#!/bin/bash
# Program:
#   This program shows the user's choice
# History
# 2016/04/21 Damon First release

read -p "Please input(Y/N):" yn
["$yn"=="Y" -o "$yn"=="y"]&&echo"OK,continue"&&exit 0
