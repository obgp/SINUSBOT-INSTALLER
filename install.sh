#!/bin/bash
# Version: v1.0
# TS3 Client Version: 3.5.3 [Stable]
# YouTube-DL Version: /
# Tested on: Debian 9, Debian 10


#variables

MACHINE=$(uname -m)
Version="v1.0"
IPADDR=$(ip route get 8.8.8.8 | awk {'print $7'} | tr -d '\n')
PW=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
AUTHOR="OBGP"

#functs

function greenMessage() {
  echo -e "\\033[32;1m${*}\\033[0m"
}

function magentaMessage() {
  echo -e "\\033[35;1m${*}\\033[0m"
}

function cyanMessage() {
  echo -e "\\033[36;1m${*}\\033[0m"
}

function redMessage() {
  echo -e "\\033[31;1m${*}\\033[0m"
}

function yellowMessage() {
  echo -e "\\033[33;1m${*}\\033[0m"
}

function errorQuit() {
  errorExit 'Exit now!'
}

function errorExit() {
  redMessage "${@}"
  exit 1
}

function errorContinue() {
  redMessage "Invalid option."
  return
}

function ytdl() {
  wget -q -O /usr/local/bin/youtube-dl http://yt-dl.org/downloads/latest/youtube-dl
  clear
  chmod a+rx /usr/local/bin/youtube-dl
  youtube-dl -U --restrict-filename
}

#check is it root
if [ "$(id -u)" != "0" ]; then
  errorExit "Change to root account required!"
fi
clear

#print tos
greenMessage "This is the automatic cracked SinusBot installer. USE AT YOUR OWN RISK"!
sleep 1
cyanMessage "You can choose between installing, upgrading and removing the SinusBot."
sleep 1
redMessage "Installer by $AUTHOR | OBGP.GITHUB.IO"
sleep 1
yellowMessage "You're using installer $Version"

#print options
redMessage "What should the installer do?"
OPTIONS=("Install" "Update" "Remove Instance" "PW Reset" "Start Instance" "Stop Instance" "YouTube-DL Install" "Quit")
select OPTION in "${OPTIONS[@]}"; do
  case "$REPLY" in
  1 | 2 | 3 | 4 | 5 | 6 | 7) break ;;
  5) errorQuit ;;
  *) errorContinue ;;
  esac
done

if [ "$OPTION" == "Install" ]; then
  INSTALL="Inst"
elif [ "$OPTION" == "Update" ]; then
  INSTALL="Updt"
elif [ "$OPTION" == "Remove Instance" ]; then
  INSTALL="Rem"
elif [ "$OPTION" == "PW Reset" ]; then
  INSTALL="Res"
elif [ "$OPTION" == "Start Instance" ]; then
  INSTALL="Start"
elif [ "$OPTION" == "Stop Instance" ]; then
  INSTALL="Stop"
elif [ "$OPTION" == "YouTube-DL Install" ]; then
  INSTALL="Ytdl"
elif [ "$OPTION" == "Quit" ]; then
  INSTALL="Quit"
fi

# update opt
if [ "$INSTALL" == "Updt" ]; then
   clear
   greenMessage "Not available in cracked script!"
fi
   
#install opt
if [ "$INSTALL" == "Inst" ]; then
  greenMessage "Installing depencies..."
  sleep 0.5
  clear
  #installing depencies
  apt-get install wget unzip -y
  apt-get update
  apt-get install debconf-utils -y
  apt-get install lsb-release -y
  apt-get update
  apt-get upgrade -y
  apt-get install chrony -y
  apt-get install ntp -y
  apt-get install -y libfontconfig libxtst6 screen xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less cron-apt python iproute2 dbus libnss3 libegl1-mesa x11-xkb-utils libasound2 libxcomposite-dev libxi6 libpci3 libxslt1.1 libxkbcommon0 libxss1  
  update-ca-certificates
  apt-get install ca-certificates bzip2 python wget -y
  update-ca-certificates
  clear
  greenMessage "Installing YouTube-DL..."
  sleep 0.5
  clear
  ytdl #calling ytdl install func
  clear
  greenMessage "Now enter port to install."
  read -p "Port [eg. 8087]: " portinst
  clear
  greenMessage "Now enter password for instance."
  read -p "Password [eg. obgp]: " passinst
  greenMessage "Allright, installing that port :P"
  #adding user
  adduser --disabled-login --home /opt/SinusPort-$portinst --gecos "" SinusPort-$portinst --force-badname
  clear
  greenMessage "Added user: SinusPort-$portinst in /opt/SinusPort-$portinst"
  sleep 0.5
  clear
  #updating
  apt-get update
  apt-get upgrade -y
  #update certificates
  update-ca-certificates
  clear
  rm -rf /tmp/.X11-unix
  rm -rf /tmp/.sinusbot.lock
  cd /opt/SinusPort-$portinst
  #downloading required files
  su -c "cd; wget https://github.com/obgp/CDN/raw/main/phpmulti-sinusbot.zip" SinusPort-$portinst
  su -c "cd; wget https://github.com/obgp/CDN/raw/main/ts3php.zip" SinusPort-$portinst
  su -c "cd; wget https://github.com/obgp/CDN/raw/main/config.zip" SinusPort-$portinst
  #extracting required files
  su -c "cd; unzip phpmulti-sinusbot.zip" SinusPort-$portinst
  su -c "cd; unzip ts3php.zip" SinusPort-$portinst
  su -c "cd; unzip config.zip" SinusPort-$portinst
  su -c "cd; mkdir -p TeamSpeak3-Client-linux_amd64/plugins; cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins/" SinusPort-$portinst
  clear
  sudo ln -sf /usr/lib_64-linux-gnu/qt5/plugins/platforms/ /usr/bin/
  clear
  #modifiying config
  sed -i s/8087/$portinst/g /opt/SinusPort-$portinst/config.ini
  sed -i s/password/$passinst/g /opt/SinusPort-$portinst/password.txt
  sed -i s/sinusbot/SinusPort-$portinst/g /opt/SinusPort-$portinst/config.ini
  rm -rf /tmp/.X11-unix
  rm -rf /tmp/.sinusbot.lock
  rm -rf /opt/SinusPort-$portinst/config.ini.dist
  rm -rf /opt/SinusPort-$portinst/config.zip
  rm -rf /opt/SinusPort-$portinst/ts3php.zip
  su -c "cd; chmod 777 *" SinusPort-$portinst 
  clear
  greenMessage "Giving permissions to user..."
  #giving permissions
  chown -R SinusPort-$portinst /opt/SinusPort-$portinst
  clear
  greenMessage "Starting Bot..."
  sleep 0.5
  clear
  #starting bot 
  su -c "cd && screen -AmdS SinusPort-$portinst ./sinusbot -override-password $passinst >/dev/null" SinusPort-$portinst
  clear
  greenMessage "Bot started!!!"
  greenMessage "Credentials are bellow:"
  #echo credentials
  echo "  > Control Panel: $IPADDR:$portinst"
  echo "  > Username: admin"
  echo "  > Password: $passinst"
  echo ""
  greenMessage "Thanks for using!!!"
fi

#remove opt
if [ "$INSTALL" == "Rem" ]; then
   clear
   greenMessage "Enter port of instance to remove."
   read -p "Port [eg. 8087]: " portrem
   clear
   greenMessage "Okay, deleting instance :)"
   sleep 0.5
   clear
   #stopping instance
   su -c "cd; pkill screen" SinusPort-$portrem
   #removing user
   userdel SinusPort-$portrem
   #removing directory
   rm -rf /opt/SinusPort-$portrem
   clear
   greenMessage "Successfully deleted instance at port: $portrem!"
fi

if [ "$INSTALL" == "Res" ]; then
   clear
   greenMessage "On which instance you want to reset password?"
   read -p "Port of instance [eg. 8087]: " portres
   clear
   greenMessage "Okay, now we will reset your password :)"
   read -p "New password [eg. OBGP]: " newpw
   clear
   greenMessage "Stopping instance at port $portres"
   sleep 0.5
   clear
   #stopping instance
   su -c "cd; pkill screen" SinusPort-$portres
   clear
   greenMessage "Changing password..."
   sleep 0.5
   #changing password
   sed -i s/password/$newpw/g /opt/SinusPort-$portres/password.txt
   clear
   greenMessage "Starting instance again..."
   sleep 0.5
   clear
   #starting bot with new password
   su -c "cd && screen -AmdS SinusPort-$portres ./sinusbot -override-password $newpw >/dev/null" SinusPort-$portres
   clear
   greenMessage "Bot started!!!"
   greenMessage "Credentials are bellow:"
   #echo credentials with new password
   echo "  > Control Panel: $IPADDR:$portres"
   echo "  > Username: admin"
   echo "  > New Password: $newpw"
   echo ""
   greenMessage "Thanks for using!!!"
fi

if [ "$INSTALL" == "Start" ]; then
   clear
   greenMessage "Enter instance port to start."
   read -p "Port [eg. 8087]: " portstart
   clear
   greenMessage "Stopping old instance (if online)..."
   su -c "cd; pkill screen" SinusPort-$portstart
   clear
   greenMessage "Starting instance at port: $portstart"
   sleep 0.5
   clear
   #creating ".sinusbot.lock" to bot can start
   echo obgp > /tmp/.sinusbot.lock
   clear
   #starting bot
   su -c "cd && screen -AmdS SinusPort-$portstart ./sinusbot >/dev/null" SinusPort-$portstart
   clear
   #removing ".sinusbot.lock"
   rm -rf /tmp/.sinusbot.lock
   clear
   PASSWORDSTART=$(cat /opt/SinusPort-$portstart/password.txt)
   clear
   greenMessage "Bot started!!!"
   greenMessage "Credentials are bellow:"
   #echo credentials
   echo "  > Control Panel: $IPADDR:$portstart"
   echo "  > Username: admin"
   echo "  > Password: $PASSWORDSTART"
   echo ""
   greenMessage "Thanks for using!!!"
fi
   
if [ "$INSTALL" == "Stop" ]; then
   clear
   greenMessage "Enter instance port to stop."
   read -p "Port [eg. 8087]: " portstop
   clear
   greenMessage "Stopping instance..."
   #stopping bot
   su -c "cd; pkill screen" SinusPort-$portstop
   clear
   greenMessage "Starting instance at port: $portstop"
   sleep 0.5
   clear
   greenMessage "Instance at port $portstop is stopped!!!"
fi

if [ "$INSTALL" == "Ytdl" ]; then
   clear
   greenMessage "Installing YouTube-DL..."
   sleep 0.5
   clear
   #calling func for installation
   ytdl
   clear
   greenMessage "YouTube-DL is installed!"
fi

if [ "$INSTALL" == "Quit" ]; then
   clear
   #print thanks for using message
   greenMessage "Thanks for using the script :)"
fi
