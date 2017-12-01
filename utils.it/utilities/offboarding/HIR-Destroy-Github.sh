#!/bin/bash
source variables.sh

echo 'This will remove a list of usernames from all of the repos that HIRs need'
echo 'Enter the full list of SFM HIRs for each campus, space separated'

read -p 'SFM User List : ' sfmlist
read -p 'ATX User List : ' atxlist
read -p 'LA User List  : ' lalist
read -p 'NYC User List : ' nyclist
read -p 'RPT User List : ' rptlist
read -p 'HRR User List : ' hrrlist

cd $tmpPath

if [ ! -z "$sfmlist" ]; then echo $sfmlist > sfmlist.tmp
cat sfmlist.tmp > alllist.tmp
	for user in $sfmlist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: SFM' sfmlist.tmp
rm sfmlist.tmp
fi
if [ ! -z "$atxlist" ]; then echo $atxlist > atxlist.tmp
cat atxlist.tmp >> alllist.tmp
	for user in $atxlist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: ATX' atxlist.tmp
rm atxlist.tmp
fi
if [ ! -z "$lalist" ]; then echo $lalist > lalist.tmp
cat lalist.tmp >> alllist.tmp
	for user in $lalist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: LA' lalist.tmp
rm lalist.tmp
fi
if [ ! -z "$nyclist" ]; then echo $nyclist > nyclist.tmp
cat nyclist.tmp >> alllist.tmp
	for user in $nyclist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: NYC' nyclist.tmp
rm nyclist.tmp
fi
if [ ! -z "$rptlist" ]; then echo $rptlist > rptlist.tmp
cat rptlist.tmp >> alllist.tmp
	for user in $rptlist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: RPT' rptlist.tmp
rm rptlist.tmp
fi
if [ ! -z "$hrrlist" ]; then echo $hrrlist > hrrlist.tmp
cat hrrlist.tmp >> alllist.tmp
	for user in $hrrlist; do
		hir-banish $user
	done
forkchop tmr hackreactor '(W) Staff: Remote' hrrlist.tmp
rm hrrlist.tmp
fi


forkchop tmr hackreactor 'Staff: Hackers in Residence' alllist.tmp
forkchop tmr hackreactor-labs '(R) HiR Team' alllist.tmp
forkchop tmr reactorcore 'HROS Admissions' alllist.tmp
forkchop tmr reactorcore '(R) HIRs and Fellows' alllist.tmp

rm alllist.tmp

cd -