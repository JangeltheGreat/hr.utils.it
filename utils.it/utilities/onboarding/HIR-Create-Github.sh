echo 'This will add a list of usernames to all of the repos that HIRs need'
echo 'Enter the full list of SFM HIRs for each campus, space separated'

read -p 'SFM User List : ' sfmlist
read -p 'ATX User List : ' atxlist
read -p 'LA User List  : ' lalist
read -p 'NYC User List : ' nyclist
read -p 'RPT User List : ' rptlist
read -p 'HRR User List : ' hrrlist

if [ ! -z "$sfmlist" ]; then echo $sfmlist > sfmlist.tmp
cat sfmlist.tmp > alllist.tmp
forkchop tma hackreactor '(W) Staff: SFM' sfmlist.tmp
rm sfmlist.tmp
fi
if [ ! -z "$atxlist" ]; then echo $atxlist > atxlist.tmp
cat atxlist.tmp >> alllist.tmp
forkchop tma hackreactor '(W) Staff: ATX' atxlist.tmp
rm atxlist.tmp
fi
if [ ! -z "$lalist" ]; then echo $lalist > lalist.tmp
cat lalist.tmp >> alllist.tmp
forkchop tma hackreactor '(W) Staff: LA' lalist.tmp
rm lalist.tmp
fi
if [ ! -z "$nyclist" ]; then echo $nyclist > nyclist.tmp
cat nyclist.tmp >> alllist.tmp
forkchop tma hackreactor '(W) Staff: NYC' nyclist.tmp
rm nyclist.tmp
fi
if [ ! -z "$rptlist" ]; then echo $rptlist > rptlist.tmp
cat rptlist.tmp >> alllist.tmp
forkchop tma hackreactor '(W) Staff: RPT' rptlist.tmp
rm rptlist.tmp
fi
if [ ! -z "$hrrlist" ]; then echo $hrrlist > hrrlist.tmp
cat hrrlist.tmp >> alllist.tmp
forkchop tma hackreactor '(W) Staff: Remote' hrrlist.tmp
rm hrrlist.tmp
fi


forkchop tma hackreactor 'Staff: Hackers in Residence' alllist.tmp
forkchop tma hackreactor-labs '(R) HiR Team' alllist.tmp
forkchop tma reactorcore 'HROS Admissions' alllist.tmp
forkchop tma reactorcore '(R) HIRs and Fellows' alllist.tmp
rm alllist.tmp





