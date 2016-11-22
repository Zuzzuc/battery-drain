#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc/
# If $2 is "", safe mode will be on. If it is 0, safe mode will be deactivated.
# If safe mode is off the processes will not be able to terminate, unless a SIGKILL(9) is sent to each and every one
mode=-1
if [ "$2" != "" ];then
	mode=$2
fi
s_e(){
	c=0
	while [ $c -lt ${#s_t[@]} ];do
		kill -9 "${s_t[$c]}"
		c=$((c+1))
	done
	exit 0
}
if [ "$mode" != "0" ];then
	trap "{ s_e ;}" 0 1 2 3 13 15
fi
def_launch=5
launch=-1
stc=0
s_t=$$
ATKL(){
	s_t[$stc]=$1
	stc=$((stc+1))
}
if [ "$1" != "" ];then
	launch=$1
else
	launch=$def_launch
fi
c=0;
while [ $c -le $launch ];do
	nohup yes >/dev/null >/dev/null 2>&1 &
	ATKL $!
	c=$((c+1))
done
echo "All spawned"
while :;do
	sleep 99
done