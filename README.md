# TrustedCert

Trusted Cert was created to make life a bit easier for android app testing while using burpsuite on a physical device. The Burp CA cert usually sits inside the User Cert profile, but is not trusted at the system level. This can cause issues with sslpinning. The script has to be run everytime the android phone is turned back on, but it helps automate the process into one simple script. 

Anyone who uses this script, just needs to download the burp cert in a .DER format and then run this script in the same folder that the cert is in. Make sure to have your android physical device plugged in and this will add the cert as a trusted system level cert. You do not need to download a cert everytime as this file will check if the file already exists and then pushes it to the phone.
