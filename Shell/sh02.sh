#!/bin/bash
# Program:
#    User input 2 integer numbers;program will cross these two numbers.
# History:
# 2016/04/21 Damon First release
echo "You SHOULD input 2 numbers,I will corss them!\n"

read -p "first number:" firstnu
read -p "second number:" secnu
total=$(($firstnu*$secnu))
echo "\nThe result of $firstnu * $secnu is ==> $total"
