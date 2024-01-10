# Make shared configuration between Asterisk instances

```bash
sudo mkdir /mnt/pbx_conf_file_share
```

```bash
if [ ! -f "/etc/smbcredentials/pbx_conf_file_share.cred" ];
then
   sudo bash -c 'echo "username=Administrator" >> /etc/smbcredentials/pbx_conf_file_share.cred';     sudo bash -c 'echo "password=K1skop1" >> /etc/smbcredentials/pbx_conf_file_share.cred'; sudo bash -c 'echo "domain=GEOLABS" >> /etc/smbcredentials/pbx_conf_file_share.cred'; 
fi
```

```bash
sudo chmod 600 /etc/smbcredentials/pbx_conf_file_share.cred
```

```bash
sudo mount -t cifs //192.168.1.100/pbxfileshare /mnt/pbx_conf_file_share -o vers=3.0,credentials=/etc/smbcredentials/pbx_conf_file_share.cred,dir_mode=0777,file_mode=0777,serverino
```

```bash
sudo bash -c 'echo "//192.168.1.100/pbxfileshare /mnt/pbx_conf_file_share cifs nofail,vers=3.0,credentials=/etc/smbcredentials/pbx_conf_file_share.cred,dir_mode=0777,file_mode=0777,serverino" >> /etc/fstab'
```

```bash
ln -s /mnt/pbx_conf_file_share/ari_additional_custom.conf ari_additional_custom.conf

sudo chown -h asterisk:asterisk ari_additional_custom.conf

ln -s /mnt/pbx_conf_file_share/extensions_custom.conf extensions_custom.conf

sudo chown -h asterisk:asterisk extensions_custom.conf

ln -s /mnt/pbx_conf_file_share/globals_custom.conf globals_custom.conf

sudo chown -h asterisk:asterisk globals_custom.conf
```