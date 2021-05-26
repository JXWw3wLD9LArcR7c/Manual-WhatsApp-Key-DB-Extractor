@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
color 0a
title Manual WhatsApp Key/DB Extractor 4.7 Enhanced 1.0 (by SimonGhoul)
echo.
echo =========================================================================
echo = This script will extract the WhatsApp Key file and DB on Android 4.0+ =
echo = You DO NOT need root for this to work but you DO need Java installed. =
echo = If your WhatsApp version is greater than 2.11.431 (most likely), then =
echo = a legacy version will be installed temporarily in order to get backup =
echo = permissions. You will NOT lose ANY data and your current version will =
echo = be restored at the end of the extraction process so try not to panic. =
echo = Script by: TripCode (Greets to all who visit: XDA Developers Forums). =
echo =  p4r4d0x86 says dragomerlin for ABE and Abinash Bishoyi are cool.     =
echo =         ###       Version: v4.7-E1.0-M (08/05/2019)        ###          =
echo =========================================================================
echo.
if not exist bin (
	echo Unable to locate the bin directory! Did you extract all the files from the & echo archive ^(maintaining structure^) and are you running from that directory?
	goto exit
)

echo Please connect your Android device with USB Debugging enabled:
echo.
bin\adb.exe kill-server
bin\adb.exe start-server
bin\adb.exe wait-for-device
bin\adb.exe shell getprop ro.build.version.sdk > tmp\sdkver.txt
set /p sdkver=<tmp\sdkver.txt
echo.
if %sdkver% leq 13 (
	set sdkver=
	echo Unsupported Android Version - this method only works on 4.0 or higher :/
	echo.
	echo Cleaning up temporary files ...
	del tmp\sdkver.txt /s /q
	goto exit
)

Echo If you have the newest Whatsapp version, it may not work. Please install the legacy from here
echo Press any key once started
Pause
http://whatcrypt.com/WhatsApp-2.11.431.apk

echo After that, please start/launch downgraded WhatsApp application if you haven't.
echo It seems to help avoiding empty or incomplete backup via ^"adb backup^" command
echo Press any key once started
pause 


echo.
echo ##### Backup Creation #####

:backup
echo You can backup using "adb backup" command (option A)
echo or you can use "bu" command and then "adb pull" (option B) (need enough storage on sdcard)
set /p backup=" A or B ? "
echo.
if /i "!backup!" == "A" (
	if %sdkver% geq 23 (
		bin\adb.exe backup -f tmp\whatsapp.ab com.whatsapp
	) else (
		bin\adb.exe backup -f tmp\whatsapp.ab -noapk com.whatsapp
	)
) else (
	if /i "!backup!" == "B" (
		if %sdkver% geq 28 (
			echo Android 9.0 or higher
			bin\adb.exe shell "bu backup com.whatsapp ^> /sdcard/whatsapp.ab"
			bin\adb.exe pull /sdcard/whatsapp.ab tmp/whatsapp.ab
		) else (
			if %sdkver% geq 23 (
				echo Android 6 to 8.1
				bin\adb.exe shell "bu 1 backup com.whatsapp ^> /sdcard/whatsapp.ab"
				bin\adb.exe pull /sdcard/whatsapp.ab tmp/whatsapp.ab
			) else (
				echo Android before 6
				bin\adb.exe shell "bu 1 backup -noapk com.whatsapp ^> /sdcard/whatsapp.ab"
				bin\adb.exe pull /sdcard/whatsapp.ab tmp/whatsapp.ab
			)
		)
	) else (
		echo Unsupported option
		goto backup
	)
)

echo.
echo ##### Backup extraction #####
if exist tmp\whatsapp.ab (
	echo.
	set /p password="Please enter your backup password (leave blank for none) and press Enter: "
	echo.
	if "!password!" == "" (
		java -jar bin\abe.jar unpack tmp\whatsapp.ab tmp\whatsapp.tar
	) else (
		java -jar bin\abe.jar unpack tmp\whatsapp.ab tmp\whatsapp.tar "!password!"
	)
	bin\tar.exe xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/f/key
	bin\tar.exe xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/msgstore.db
	bin\tar.exe xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/wa.db
	bin\tar.exe xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/axolotl.db
	bin\tar.exe xvf tmp\whatsapp.tar -C tmp\ apps/com.whatsapp/db/chatsettings.db
	echo.
	if exist tmp\apps\com.whatsapp\f\key (
		echo Extracting whatsapp.cryptkey ...
		copy tmp\apps\com.whatsapp\f\key extracted\whatsapp.cryptkey
		echo.
	)
	if exist tmp\apps\com.whatsapp\db\msgstore.db (
		echo Extracting msgstore.db ...
		copy tmp\apps\com.whatsapp\db\msgstore.db extracted\msgstore.db
		echo.
	)
	if exist tmp\apps\com.whatsapp\db\wa.db (
		echo Extracting wa.db ...
		copy tmp\apps\com.whatsapp\db\wa.db extracted\wa.db
		echo.
	)
	if exist tmp\apps\com.whatsapp\db\axolotl.db (
		echo Extracting axolotl.db ...
		copy tmp\apps\com.whatsapp\db\axolotl.db extracted\axolotl.db
		echo.
	)
	if exist tmp\apps\com.whatsapp\db\chatsettings.db (
		echo Extracting chatsettings.db ...
		copy tmp\apps\com.whatsapp\db\chatsettings.db extracted\chatsettings.db
		echo.
	)
	if exist tmp\apps\com.whatsapp\f\key (
		echo Pushing cipher key to: %sdpath%/WhatsApp/Databases/.nomedia
		bin\adb.exe push tmp\apps\com.whatsapp\f\key %sdpath%/WhatsApp/Databases/.nomedia
		echo.
	)
) else (
	echo Backup extraction failed
)

:clean	
echo Cleaning up temporary files ...
echo.
if exist tmp\whatsapp.ab (
	del tmp\whatsapp.ab /s /q
)
if exist tmp\whatsapp.tar (
	del tmp\whatsapp.tar /s /q
)
if exist tmp\apps (
	rmdir tmp\apps /s /q
)
echo Done


:exit
echo.
echo Exiting ...
echo.
set sdkver=
set password=
bin\adb.exe kill-server
pause
exit
