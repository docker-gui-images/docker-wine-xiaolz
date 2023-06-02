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

xiaolz_exe=$(basename "$(find /home/user/xiaolz -maxdepth 1 -type f -name 'С���ӿ��*.exe' | head -n 1)")

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
	# ��Q �˳���ֱ������ wine��Ȼ���ؿ���
	# ��Ϊ��Q ����֮��Ļ��Լ������������԰����� wine �ɵ��������ȽϿ���
	# ԭ��Ŀ�Կ�Q�Ĵ������ȽϿ���, С���ӿ��Ҳ����ʹ��ͬ���ķ���.
	echo "[XLZDaemon] xiaolz exited. Killing wine ..."
	wine wineboot --kill
	wineserver -k9
	echo "[XLZDaemon] xiaolz will start after 3 seconds ..."
	sleep 3
done
