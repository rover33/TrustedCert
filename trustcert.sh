#!/bin/bash

ART="
 ______             __         __  _____        __ 
/_  __/_____ _____ / /____ ___/ / / ___/__ ____/ /_
 / / / __/ // (_-</ __/ -_) _  / / /__/ -_) __/ __/
/_/_/_/  \_,_/___/\__/\__/\_,_/  \___/\__/_/  \__/ 
  / _ )__ __                                       
 / _  / // /                                       
/____/\_, /             ____ ____                  
  ___/___/_  _____ ____|_  /|_  /                  
 / __/ _ \ |/ / -_) __//_ <_/_ <                   
/_/__\___/___/\__/_/ /____/____/                   
 / __/___                                          
 > _/_ _/      __                                  
|_____/ _  ___/ /______ ___  ___ ________          
/ __/  ' \/ _  /___(_-</ _ \/ _ '/ __/ -_)         
\__/_/_/_/\_,_/   /___/ .__/\_,_/\__/\__/          
                     /_/                           
"
echo "$ART"
read -p "Press Enter to continue"

current_dir="$(pwd)"
    is_der=$(find . -name "*.der")
    is_zero=$(find . -name "*.0")
	if [[ $is_der == "" && $is_zero == "" ]]
		then
			echo "Please export a Burp certificate in DER format"
            echo "Here's a handy link: https://portswigger.net/burp/documentation/desktop/tools/proxy/manage-certificates#:~:text=You%20can%20export%20your%20installation,the%20Export%20or%20Import%20options."
			exit
  elif [[ $is_der != "" && $is_zero == "" ]]
    then
      openssl x509 -inform DER -in "$is_der" -out burp.pem
      output=$(openssl x509 -inform PEM -subject_hash_old -in burp.pem |head -1)
      mv burp.pem $output.0
      echo "Certificate was generated. Moving on..."
  fi

adb push  9a5ba575.0 /sdcard/

adb shell <<EOF

su
mkdir -m 700 /sdcard/certs
cp /system/etc/security/cacerts/* /sdcard/certs/
mount -t tmpfs tmpfs /system/etc/security/cacerts
mv /sdcard/certs/* /system/etc/security/cacerts/
mv /sdcard/9a5ba575.0 /system/etc/security/cacerts/
chown root:root /system/etc/security/cacerts/*
chmod 644 /system/etc/security/cacerts/*
chcon u:object_r:system_file:s0 /system/etc/security/cacerts/*
echo "Certificate has been added at the system level"