#!/bin/bash
# Set them to empty is NOT SECURE but avoid them display in random logs.
export VNC_PASSWD=''
export USER_PASSWD=''
export HTTP_AUTH_USER=''
export HTTP_AUTH_PASSWD=''

export TERM=linux
export LC_CTYPE=zh_CN.GBK
export WINEDEBUG=-all
export XMODIFIERS=@im=fcitx

xiaolz_exe=$(basename "$(find /home/user/xiaolz -maxdepth 1 -type f -name '小栗子框架*.exe' | head -n 1)")

while true; do
	echo "[XLZDaemon] Starting xiaolz ...."
	wine "/home/user/xiaolz/$xiaolz_exe" &
	echo "[XLZDaemon] Started xiaolz ."
	wait $!
	echo "[XLZDaemon] xiaolz exited, maybe updated."
	echo "[XLZDaemon] Searching for the new process ..."
	sleep 3
	xiaolz_pid=$(pgrep -a "" | grep -v grep | grep "/$xiaolz_exe" | head -n 1 | awk '{print $1}')
	if [ "$xiaolz_pid" == "" ]; then
		echo "[XLZDaemon] No xiaolz process found, start new process ..."
	else
		echo "[XLZDaemon] Found xiaolz process, it's okay."
		tail -f /dev/null --pid=$xiaolz_pid
	fi
	# 酷Q 退出后直接重启 wine，然后重开。
	# 因为酷Q 更新之类的会自己开回来，所以把整个 wine 干掉重启，比较靠谱
	# 原项目对酷Q的处理方案比较靠谱, 小栗子框架也可以使用同样的方法.
	echo "[XLZDaemon] xiaolz exited. Killing wine ..."
	wine wineboot --kill
	wineserver -k9
	echo "[XLZDaemon] xiaolz will start after 3 seconds ..."
	sleep 3
done
