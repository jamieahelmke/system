#!/bin/env sh

# requirements: ffmpeg4.4 or higher, wget

# execute as root user!

# creating install directory
mkdir /opt/jellyfin
cd /opt/jellyfin

# fetching app
wget https://repo.jellyfin.org/releases/server/linux/stable/combined/jellyfin_10.7.7_amd64.tar.gz
tar xvzf jellyfin_10.7.7_amd64.tar.gz
ln -s jellyfin_10.7.7 jellyfin 
mkdir data cache config log

# Run Jellyfin
printf("
#!/bin/bash
JELLYFINDIR="/opt/jellyfin"
FFMPEGDIR="/usr/share/jellyfin-ffmpeg"

$JELLYFINDIR/jellyfin/jellyfin \
 -d $JELLYFINDIR/data \
 -C $JELLYFINDIR/cache \
 -c $JELLYFINDIR/config \
 -l $JELLYFINDIR/log \
 --ffmpeg $FFMPEGDIR/ffmpeg
") >> jellyfin.sh

chown -R jellyfin:jellyfin * 
chmod u+x jellyfin.sh

echo "### END ###"


