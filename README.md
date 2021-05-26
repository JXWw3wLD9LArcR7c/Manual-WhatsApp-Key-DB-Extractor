# The Manual WhatsApp Key/DB Extractor
Allows WhatsApp users to extract their cipher key and databases on non-rooted Android devices.
This version is intended to be foolproof, it has to work. It's focus is to help manually diagnose errors that the original has and make people do more work manually. It might be more work but at least you can make sure that this will work. There are some key differences and disadvantages though (basically, less automation)
I had a lot of issues with the original one, stuff like not finding a file and etc. I said fuck this and did it myself and I used the code as a guide, and it worked.

Pls fork if I don't maintain it

For a more automated and less hands-on version of this, visit https://github.com/p4r4d0x86/WhatsApp-Key-DB-Extractor/

###### KEY DIFFERENCES:

- You are expected to install the old whatsapp apk yourself
- Your whatsapp version prior to running this is not backed up. You are going to have to find a way to download it online
- No powershell or sh version. Might do powershell though (not sh, I am not familiar with it)
- No backup (You should not lose data if you unnistall whatsapp, I still advice you to backup)
- No checks at all. Nothing is going to tell you that have the right version

###### BRANCH UPDATES:
v4.7-E1.0-B - Unofficial version to fix some errors which appear on newer android versions (7+). Also the first version used on this fork
v4.0 - Fixed issues with Android API 14-17 (4.0-4.2 Jelly Bean).
v4.1 - Added support for Android API 23 (6.0-6.0.1 Marshmallow).
v4.2 - Added support for specifying adb backup passwords.
v4.3 - Added PowerShell version as optional alternative to bat version.
v4.4 - Changed primary mirror for legacy apk.
v4.5 - Fixed issue pushing cipher key to emulated storage.
v4.6 - Updated primary mirror for legacy apk (again).
v4.7 - Added new sanity checks and support for Android API 24 (7.0 Nougat).

###### PREREQUISITES:
 1. O/S: Windows Vista, Windows 7, Windows 8, Windows 10 
 2. Java - If not installed: https://www.java.com/en/download/  
 3. ADB (Android Debug Bridge) Drivers - If not installed: https://developer.android.com/studio/releases/platform-tools
 4. USB Debugging must be enabled on the target device. Settings -> Developer Options -> (Debugging) USB debugging  
     If you cannot find Developer Options then please go to: Settings -> About phone/device and tap the Build number  
     multiple times until you're finally declared a developer.  
 5. Android device with Android 4.0 or higher. I.E. Ice Cream Sandwich, Jelly Bean, KitKat, Lollipop, Marshmallow or Nougat.  


###### INSTRUCTIONS:
 1. Extract "WhatsApp-Key-DB-Extractor-master.zip" maintaining the directory structure.  
 2. Click on "WhatsAppKeyDBExtract.bat" (Windows)  
 3. Connect your device via USB, unlock your screen and wait for "Full backup" to appear.  
 4. Enter your backup password or leave blank (if none set) and tap on "Back up my data".  
 5. Confirm backup password in your command console and then check your "extracted" folder.  
 

###### TROUBLESHOOTING:
 1. If you have never used USB Debugging before, you may also need to verify the fingerprint.  
 2. If you have set a default backup password in your Android settings, then this MUST be the  
     backup password that you PROVIDE when prompted to backup your data. Else it WILL fail!  
 3. Linux and Mac OS X users may need to set the script permissions as executable. Depending on the  
     adb permissions, you may also need to "sudo ./WhatsAppKeyDBExtract.sh" from your command console.  
 4. If you're having issues with "WhatsAppKeyDBExtract.bat" then right click "WhatsAppKeyDBExtract.ps1"  
     and select "Run with PowerShell". You may have to enter "y" at first run for execution policy.  
 5. If you get an error saying "AES encryption not allowed" then you need to update your Oracle Java  
    Cryptography Extension (JCE) to Unlimited Strength Jurisdiction Policy Files.  


###### CREDITS:
 AUTHOR: TripCode & p4r4d0x86
