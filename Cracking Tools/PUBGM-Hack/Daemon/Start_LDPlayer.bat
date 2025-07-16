@echo off
color b
pushd %~dp0

set ADB_PATH=data\adb\adb.exe

%ADB_PATH% kill-server
%ADB_PATH% start-server 

%ADB_PATH% forward tcp:9990 tcp:9990

echo Pushing daemon...
%ADB_PATH% push data\daemon /data/local/tmp
%ADB_PATH% shell "chmod +x /data/local/tmp/daemon"
%ADB_PATH% shell "pkill -f daemon"

cls

echo Daemon Status: Running!
echo You can start the hack now!
echo (Don't close this CMD window!)

%ADB_PATH% shell "fuser -k 9990/tcp"
%ADB_PATH% shell "nohup /data/local/tmp/daemon &"

pause