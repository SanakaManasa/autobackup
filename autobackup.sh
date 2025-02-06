#!/bin/bash

# Backup Configuration
BACKUP_SRC="$HOME/Documents"  # Change this to the folder you want to back up
BACKUP_DEST="$HOME/backups"
LOG_FILE="$BACKUP_DEST/backup.log"
MAX_BACKUPS=5  # Number of backups to keep
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# Create Backup Destination Folder if Not Exists
mkdir -p "$BACKUP_DEST"

# Create a backup
echo "[$(date)] Starting backup..." | tee -a "$LOG_FILE"
tar -czf "$BACKUP_DEST/$BACKUP_NAME" "$BACKUP_SRC" 2>>"$LOG_FILE"

# Log Backup Completion
echo "[$(date)] Backup created: $BACKUP_DEST/$BACKUP_NAME" | tee -a "$LOG_FILE"

# Backup Rotation - Keep Only Last 5 Backups
BACKUPS=($(ls -t "$BACKUP_DEST"/backup_*.tar.gz))
if (( ${#BACKUPS[@]} > MAX_BACKUPS )); then
    DELETE_COUNT=$((${#BACKUPS[@]} - MAX_BACKUPS))
    for ((i=MAX_BACKUPS; i<${#BACKUPS[@]}; i++)); do
        rm -f "${BACKUPS[$i]}"
        echo "[$(date)] Deleted old backup: ${BACKUPS[$i]}" | tee -a "$LOG_FILE"
    done
fi

# Send a Desktop Notification (Optional, works on Linux & Mac)
if command -v notify-send &> /dev/null; then
    notify-send "Backup Completed" "Your backup was successfully created at $BACKUP_DEST/$BACKUP_NAME"
elif command -v osascript &> /dev/null; then
    osascript -e "display notification \"Backup Completed\" with title \"Auto Backup\""
fi

echo "[$(date)] Backup process completed!" | tee -a "$LOG_FILE"
