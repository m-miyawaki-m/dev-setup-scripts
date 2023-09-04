#!/bin/bash

SCRIPT_NAME=$(basename $0)

# 処理開始時のタイムスタンプを取得（秒とナノ秒）
START_TIME=$(date +%s.%N)

echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理開始] - $SCRIPT_NAME" | tee -a /home/vscode/scripts/logs/server.log
echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理開始] - $SCRIPT_NAME" | tee -a /home/vscode/scripts/logs/server.log

CRON_PID=$(pgrep -x "cron")
echo "Debug: CRON PID = $CRON_PID"
if [ ! -z "$CRON_PID" ];
then
    echo "[INFO][$(date +'%Y%m%d:%H%M%S')] - CRON is already running." | tee -a /home/vscode/scripts/logs/server.log
else
    # 正常コマンド
    sudo service cron start
    # テスト用起動失敗コマンド
    # sudo service cron fail
    if [ $? -eq 0 ]
    then
        echo "[INFO][$(date +'%Y%m%d:%H%M%S')] - CRON started successfully." | tee -a /home/vscode/scripts/logs/server.log
    else
        echo "[INFO][$(date +'%Y%m%d:%H%M%S')] - Failed to start CRON." | tee -a /home/vscode/scripts/logs/server.log
    fi
fi

# 処理終了時のタイムスタンプを取得（秒とナノ秒）
END_TIME=$(date +%s.%N)

# 処理時間を計算（bcコマンドを使用）
ELAPSED_TIME=$(echo "$END_TIME - $START_TIME" | bc)

echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理終了] - $SCRIPT_NAME" | tee -a /home/vscode/scripts/logs/server.log
echo "[INFO][$(date +'%Y%m%d:%H%M%S')][処理時間計測] - $ELAPSED_TIME 秒" | tee -a /home/vscode/scripts/logs/server.log