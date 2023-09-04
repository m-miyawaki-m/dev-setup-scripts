#!/bin/bash

# パスを変数で管理
BASE_DIR="/home/vscode/develop/dev-setup-scripts_0904_2"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/cron.log"

# ログディレクトリを作成（既に存在していてもエラーを出さない）
mkdir -p $LOG_DIR

# logファイルが存在しない場合に作成
touch $LOG_FILE

# 現在の日時を指定したファイルに上書き
SCRIPT_NAME=$(basename $0)
echo "[INFO][$(date +'%Y%m%d:%H%M%S')][定期実行] - $SCRIPT_NAME" | tee -a $LOG_FILE