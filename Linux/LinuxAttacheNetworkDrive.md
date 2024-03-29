# How to Attach a Network Drive in Linux

To attach (or mount) a network drive in Linux, you'll commonly use the Network File System (NFS) or Samba (for Windows shares). Here's how to do it for both:

## 1. NFS (Network File System)

1. First, make sure you have the required package installed. On a Debian-based system, you can do:

   ```bash
   sudo apt update
   sudo apt install nfs-common
   ```

1. Create a directory where you want to mount the network drive:

   ```bash
   sudo mkdir /mnt/my_network_drive
   ```

1. Mount the NFS share:

   ```bash
   sudo mount -t nfs [IP_or_HOSTNAME]:/path/to/nfs/share /mnt/my_network_drive
   ```

1. To make the mount permanent, you can add it to `/etc/fstab`:

   ```bash
   echo "[IP_or_HOSTNAME]:/path/to/nfs/share /mnt/my_network_drive nfs defaults 0 0" | sudo tee -a /etc/fstab
   ```

## 2. Samba (for Windows shares or Samba shares)

1. Make sure you have the required packages installed:

   ```bash
   sudo apt update
   sudo apt install cifs-utils
   ```

1. Create a directory where you want to mount the network drive:

   ```bash
   sudo mkdir /mnt/my_network_drive
   ```

1. If the Windows share requires a username and password, create a credentials file:

   ```bash
   echo "username=YOUR_USERNAME" > ~/smbcreds
   echo "password=YOUR_PASSWORD" >> ~/smbcreds
   chmod 600 ~/smbcreds
   ```

1. Mount the Samba share:

   ```bash
   sudo mount -t cifs //IP_or_HOSTNAME/sharename /mnt/my_network_drive -o credentials=~/smbcreds
   ```

   If the share doesn't require a username and password, you can omit the `-o credentials=~/smbcreds` part.

1. To make the mount permanent, add it to `/etc/fstab`:

   ```bash
   echo "//IP_or_HOSTNAME/sharename /mnt/my_network_drive cifs credentials=/home/YOUR_USERNAME/smbcreds 0 0" | sudo tee -a /etc/fstab
   ```

Always remember to replace placeholders (like `YOUR_USERNAME`, `YOUR_PASSWORD`, `IP_or_HOSTNAME`, etc.) with the actual values.

And finally, before making any changes to `/etc/fstab`, it's always a good idea to back it up. An incorrect entry can make your system unbootable. Always test new fstab entries with `sudo mount -a` before rebooting.
