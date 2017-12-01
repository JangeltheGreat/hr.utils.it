#!/bin/bash
source variable.sh

read -p "what file should I be using? " -e csv

gam csv $csv gam update user ~ID password ~individualPW changepassword true