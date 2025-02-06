Commands used:
1. Shebang (#!/bin/bash)
This line at the top of the script tells the computer to use the Bash shell to run the commands in the script. It's like telling the computer which tool to use to understand and execute the script.

2. Define Source Directory (SOURCE_DIR="/path/to/source")
This line sets the source directory—the folder that contains the files you want to back up. You'll replace "/path/to/source" with the actual path to the folder you want to back up.

3. Define Destination Directory (DEST_DIR="/path/to/destination")
This line sets the destination directory, which is the folder where the backup will be saved. You replace "/path/to/destination" with the location where you want your backup to be stored.

4. Create a Unique Timestamp (TIMESTAMP=$(date +"%Y%m%d%H%M%S"))
This command creates a unique timestamp based on the current date and time (e.g., 20250206153045 for February 6, 2025, 3:30:45 PM). It's used to give each backup a unique name so it doesn't overwrite the previous one.

5. Set Backup Folder Name (BACKUP_DIR="${DEST_DIR}/backup_${TIMESTAMP}")
This line combines the destination folder and the timestamp to create a new backup folder name. For example, it might create a folder like backup_20250206153045 to store your files.

6. Copy Files to Backup Folder (cp -r $SOURCE_DIR $BACKUP_DIR)
The cp command copies the files and folders from the source folder to the backup folder.
The -r flag means to copy everything, including all subfolders and files within them.

7. Print Confirmation (echo "Backup completed: ${BACKUP_DIR}")
This command prints a message on the screen that confirms the backup is complete and shows the path to the backup folder.
