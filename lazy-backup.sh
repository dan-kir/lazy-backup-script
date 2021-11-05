#!/bin/bash
# Creates an archive of specified filesystem dirs to /home

dateStamp=$(date +"%Y%m%d")

sourceDirs=(\
	"/etc/aide" \
	"/etc/apt" \
	"/etc/default" \
	"/etc/ssh" \
	"/etc/wireguard" \
	"/etc/libvirt" \
	"/boot" \
	"/root" \
	"/var/log" \
	"/var/mail"
)
backupFile="$dateStamp-system-backup.tar.bz2"
backupsFolder="/home/dan/FsBackups"

echo "Beginning a backup to destination ${backupsFolder} "

mkdir -p $backupsFolder
mkdir -p $backupsFolder/$dateStamp-backup

# For each in sourceDirs cp to backupsFolder
for i in "${sourceDirs[@]}"
do
	cp -Rp $i $backupsFolder/$dateStamp-backup/
done

echo "Compressing backup with bzip2"
tar cjf $backupsFolder/$backupFile $backupsFolder/$dateStamp-backup/ 2>/dev/null

# Set permissions on $backupFolder
chown -R dan:dan $backupsFolder
chmod go-rwx $backupsFolder

echo "Cleaning up"
rm -rf $backupsFolder/$dateStamp-backup

echo "Done!"
du -h $backupsFolder/$backupFile
