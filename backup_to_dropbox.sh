# Backup script by Kristian Risager Larsen
# https://github.com/kristianrl/backup-to-dropbox/

# Settings
DATE="`date +%Y-%m-%d_%H-%M`"
DATABASE=" --all-databases --ignore-table=mysql.event "
BACKUPSET="SERVERNAME"
BACKUPROOT="/root/backup"
FILES="/var/www /etc/apache2 /etc/mysql"

# Delete yesterday's backup files.
rm $BACKUPROOT/$BACKUPSET.*

# Dump MySQL databases. The password is stored in ~/.my.cnf
mysqldump -u root $DATABASE | gzip -9 -c > $BACKUPROOT/$BACKUPSET.$DATE.sql.gz

# Upload to Dropbox. https://github.com/andreafabrizi/Dropbox-Uploader
/root/dropbox_uploader.sh -q upload $BACKUPROOT/$BACKUPSET.$DATE.sql.gz $BACKUPSET.$DATE.sql.gz

# Compress files.
tar -zcf $BACKUPROOT/$BACKUPSET.$DATE.tar.gz $FILES

# Upload to Dropbox
/root/dropbox_uploader.sh -q upload $BACKUPROOT/$BACKUPSET.$DATE.tar.gz $BACKUPSET.$DATE.tar.gz
