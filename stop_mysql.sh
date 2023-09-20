#!/bin/bash

SCRIPT_NAME=$(basename $0)

# 処理開始時のタイムスタンプを取得（秒とナノ秒）
START_TIME=$(date +%s.%N)

echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理開始] - $SCRIPT_NAME" | tee -a /home/vscode/scripts/logs/server.log

# MySQLが動いているかの確認
MYSQLD_PID=$(pgrep -x "mysqld")
echo "Debug: MYSQLD PID = $MYSQLD_PID"
if [ ! -z "$MYSQLD_PID" ];
then
    # MySQLが動いていれば停止
    sudo service mysql stop
    if [ $? -eq 0 ]
    then
        echo "[INFO][$(date +'%Y%m%d:%H%M%S')] - MySQLD stopped successfully." | tee -a /home/vscode/scripts/logs/server.log
    else
        echo "[ERROR][$(date +'%Y%m%d:%H%M%S')] - Failed to stop MySQLD." | tee -a /home/vscode/scripts/logs/server.log
    fi
else
    echo "[INFO][$(date +'%Y%m%d:%H%M%S')] - MySQLD is not running." | tee -a /home/vscode/scripts/logs/server.log
fi

# 処理終了時のタイムスタンプを取得（秒とナノ秒）
END_TIME=$(date +%s.%N)

# 処理時間を計算（bcコマンドを使用）
ELAPSED_TIME=$(echo "$END_TIME - $START_TIME" | bc)

echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理終了] - $SCRIPT_NAME" | tee -a /home/vscode/scripts/logs/server.log
echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理時間計測] - $ELAPSED_TIME 秒" | tee -a /home/vscode/scripts/logs/server.log