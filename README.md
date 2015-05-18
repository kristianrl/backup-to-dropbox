# Backup script


Simple backup script for LAMP servers, using [Andrea Fabrizi's Dropbox Uploader script](https://github.com/andreafabrizi/Dropbox-Uploader).

The default settings should work for any standard LAMP installation, but is easy to modify.

# Preparing the script
Go to the root directory, given that you want the script to run as root, and download the script.

    sudo su
    cd /root/
    curl "https://raw.githubusercontent.com/kristianrl/backup-to-dropbox/master/backup_to_dropbox.sh" -o backup_to_dropbox.sh
    chmod 700 backup_to_dropbox.sh
    mkdir /root/backup

Install and configure [Andrea Fabrizi's Dropbox Uploader script](https://github.com/andreafabrizi/Dropbox-Uploader), e.g. by running `curl "https://raw.github.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh; chmod +x dropbox_uploader.sh; ./dropbox_uploader.sh`

Create a file called `.my.cnf`, e.g. by running `nano /root/.my.cnf; chmod 600 /root/.my.cnf`, and add the following:

    [client]
    password=YOUR_MYSQL_ROOT_ACCOUNT_PASSWORD

Configure the script by running `nano /root/backup_to_dropbox.sh`. At least you need to change the `BACKUPSET` value.

Add the following to your crontab in order to run the script nightly at 02:15. You can run `crontab -e`

    # Backup script
    15 02 * * * /root/backup_to_dropbox.sh
