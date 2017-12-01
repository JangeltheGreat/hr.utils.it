#!/bin/bash
source variable.sh

read -p "what file should I be using? " -e csv

gam csv $csv gam select hackreactor user hir.admin modify calendars ~calendar_id summary ~cal_name
gam csv $csv gam select hackreactor calendar ~calendar_id add editor ~Current_HiR