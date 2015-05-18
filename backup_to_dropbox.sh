# Backup script by Kristian Risager Larsen
# https://github.com/kristianrl/backup-to-dropbox/

# Settings
DATE="`date +%Y-%m-%d_%H-%M`"
DATABASE=" --all-databases --ignore-table=mysql.event "
BACKUPSET="SERVERNAME"
BACKUPROOT="/root/backup"
WEBROOT="/var/www /etc/apache2 /etc/mysql"

# Remove yesterday's settings
rm $BACKUPROOT/$BACKUPSET.*

# password in ~/.my.cnf
mysqldump -u root $DATABASE | gzip -9 -c > $BACKUPROOT/$BACKUPSET.$DATE.sql.gz

# https://github.com/andreafabrizi/Dropbox-Uploader
/root/dropbox_uploader.sh -q upload $BACKUPROOT/$BACKUPSET.$DATE.sql.gz $BACKUPSET.$DATE.sql.gz

# Compress
tar -zcf $BACKUPROOT/$BACKUPSET.$DATE.tar.gz $WEBROOT

# Upload to Dropbox
/root/dropbox_uploader.sh -q upload $BACKUPROOT/$BACKUPSET.$DATE.tar.gz $BACKUPSET.$DATE.tar.gz
