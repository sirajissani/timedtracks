
MPC="mpc -h 192.168.1.2"
DELIM=";"
#timestring=$2

timeLimit=`echo $1 |grep -E "^[0-9]+:[0-9]+:[0-9]+"`
if [ -z "$timeLimit" ]; then
    timeLimit=`echo $1 |grep -E "[0-9]+:[0-9]+"`
    if [ -z "$timeLimit" ]; then
        timeLimit=`echo $1 |grep -E "[0-9]+"`
        if [ -z "$timeLimit" ]; then
            timeLimit="00:30:00"
        else
            timeLimit="$1 sec"
        fi
    else
        timeLimit="00:$timeLimit"
    fi
fi

if [ -n "$2" ]; then
    PLAYLIST=`$MPC lsplaylists | grep -E "$2"`
fi

if [ -z "$PLAYLIST" ]; then
    PLAYLIST="playlist"
    echo "Shuffling current playlist to run for $timeLimit."
else
    echo "Shuffling $PLAYLIST playlist to run for $timeLimit."
    $MPC clear -q
    $MPC load $PLAYLIST
fi

$MPC playlist -f %time%$DELIM%file% | sort -R > shuffle.play

rm timedplay.m3u

declare -i totalSecs trackSecs limitSecs
let limitSecs=`date --utc --date "1970-01-01 $timeLimit" +%s`
while read entry
do
    trackLen=`echo $entry | sed -r "s/(.*)$DELIM(.*)/\1/g"`
    fileName=`echo $entry | sed -r "s/(.*)$DELIM(.*)/\2/g"`
    trackSecs=`date --utc --date "1970-01-01 00:0$trackLen" +%s`

    if [ "$(($totalSecs+$trackSecs))" -gt  "$limitSecs" ]; then
        echo Playlist created for `date -ud @$totalSecs +%T`
        break
    fi
    echo $fileName >> timedplay.m3u
    totalSecs=$totalSecs+$trackSecs;
    #echo $trackSecs $trackLen $totalSecs
done < shuffle.play

rm shuffle.play

