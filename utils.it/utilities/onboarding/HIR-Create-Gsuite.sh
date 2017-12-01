#!/bin/bash
source variables.sh

cd $csvPath

read -p "what file should I be using? " -e csv

gam csv $csv gam select hackreactor create user ~ID firstname ~first lastname ~last password ~tempPW

sleep 5

gam csv $csv gam select hackreactor user ~ID add groups member ~GroupList
gam csv $csv gam select hackreactor calendar ~ID add owner Admissionsemail@hackreactor.com
gam csv $csv gam select hackreactor calendar ~ID add owner admissions.admin@makersquare.com
gam csv $csv gam select hackreactor calendar ~ID add owner hir.admin@hackreactor.com
gam csv $csv gam select hackreactor calendar ~ID add owner ~HIR_director1
gam csv $csv gam select hackreactor calendar ~ID add owner ~HIR_director2
gam csv $csv gam select hackreactor calendar ~HIRcalendar add editor ~Email

cd -