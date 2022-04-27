@echo off
setlocal enabledelayedexpansion

	chcp 65001 > nul
	REM CLS
	SET /A VERSIYON = 31
	SET YAZIRENK=0B
	SET ARKARENK=B0
	mode con cols=61 lines=27
	title Передача файлов между устройствами v%VERSIYON% ^| Jokedr
	set HedefTestServer=\\YOUR_SERVER\
	set HedefOtomasyon=\\YOUR_SERVER2\
	set HedefMasaustu=%USERPROFILE%\Desktop
	set HedefYedek=D:\UPDATE_BACKUP
	set TvS=%date%_%time%
	set TarihVeSaat=%TvS:~10,4%%TvS:~7,2%%TvS:~4,2%_%TvS:~15,2%%TvS:~18,2%%TvS:~21,2%

:Anasayfa
		call :color %YAZIRENK%
		REM YOL1
		set /a MENUSINIR=38
		set "YOL1=0"
		if not defined HedefTestServer goto YOLSONUC1CLASS
		:YOL1CLASS
		if not "!HedefTestServer:~%YOL1%,1!" == "" (
			set /A YOL1+=1
			goto YOL1CLASS
		)
		:YOLSONUC1CLASS
		set /a "YOLSONUC1=0"
		set /a "Count1=%MENUSINIR%-%YOL1%"
		for /l %%a in (1,1,%Count1%) do call set "YOLSONUC1=%%YOLSONUC1%% "
		REM YOL2
		set "YOL2=0"
		if not defined HedefOtomasyon goto YOLSONUC2CLASS
		:YOL2CLASS
		if not "!HedefOtomasyon:~%YOL2%,1!" == "" (
			set /A YOL2+=1
			goto YOL2CLASS
		)
		:YOLSONUC2CLASS
		set /a "YOLSONUC2=0"
		set /a "Count2=%MENUSINIR%-%YOL2%"
		for /l %%a in (1,1,%Count2%) do call set "YOLSONUC2=%%YOLSONUC2%% "
		REM YOL3
		set "YOL3=0"
		if not defined HedefMasaustu goto YOLSONUC3CLASS
		:YOL3CLASS
		if not "!HedefMasaustu:~%YOL3%,1!" == "" (
			set /A YOL3+=1
			goto YOL3CLASS
		)
		:YOLSONUC3CLASS
		set /a "YOLSONUC3=0"
		set /a "Count3=%MENUSINIR%-%YOL3%"
		for /l %%a in (1,1,%Count3%) do call set "YOLSONUC3=%%YOLSONUC3%% "
		REM YOL4
		set "YOL4=0"
		if not defined HedefYedek goto YOLSONUC4CLASS
		:YOL4CLASS
		if not "!HedefYedek:~%YOL4%,1!" == "" (
			set /A YOL4+=1
			goto YOL4CLASS
		)
		rem 39 sinir
		:YOLSONUC4CLASS
		set /a "YOLSONUC4=0"
		set /a "Count4=%MENUSINIR%-%YOL4%"
		for /l %%a in (1,1,%Count4%) do call set "YOLSONUC4=%%YOLSONUC4%% "
	echo.╔═══════════════════════════════════════════════════════════╗
	echo.║ »»» Cihazlar Arası Dosya Transfer v%VERSIYON% ^| CEMRESHIPYARD ««« ║
	echo.╠═══════════════════════════════════════════════════════════╣
	echo ║ » 1. TestServer/Otomasyon Transfer (Notepad++)            ║
	echo ║ » 2. TestServer/Otomasyon Transfer (Pano)                 ║
	echo ║ » 3. TestServer/Otomasyon Transfer (Txt)                  ║
	echo ║ » 4. TestServer/Masaüstü  Transfer (Txt)                  ║
	echo ║ » 5. Otomasyon/Masaüstü   Transfer (Txt)                  ║
	echo ║ » 6. Otomasyon/TestServer Transfer (Txt)                  ║
	echo ║ » 7. Cıkış                                                ║
	echo.╠═══════════════════════════════════════════════════════════╣
	echo ║ » TestServer Yolu: %HedefTestServer% %YOLSONUC1:~2% ║
	echo ║ » Otomasyon  Yolu: %HedefOtomasyon% %YOLSONUC2:~2% ║
	echo ║ » Masaüstü   Yolu: %HedefMasaustu% %YOLSONUC3:~2% ║
	echo ║ » Yedek      Yolu: %HedefYedek% %YOLSONUC4:~2% ║
	echo.╠═══════════════════════════════════════════════════════════╣
	choice  /N /C:1234567 /M " ║ »  Yapacağınız İşlemi Seçiniz (1,2,3,4,5,6 veya 7)        ║╚═══════════════════════════════════════════════════════════╝"

	if errorlevel ==7 goto Cikis
	if errorlevel ==6 goto OtomasyondanTestServer
	if errorlevel ==5 goto OtomasyondanMasaustu
	if errorlevel ==4 goto TestServerdanMasaustu	
	if errorlevel ==3 goto TestServerdanOtomasyon
	if errorlevel ==2 goto TestServerdanOtomasyonPano
	if errorlevel ==1 goto TestServerdanOtomasyonAcikDosya	
	
:TestServerdanOtomasyonAcikDosya
		set /A "SayacYedek=0"
		set /A "SayacTransfer=0"
		set /A "TRANSFERSINIR=9"
		echo.════════════════════════════════════════════════════════════
		if %1=="" ("BOS") else (
			echo YEDEK...
			mkdir %HedefYedek%\%TarihVeSaat%
			echo.════════════════════════════════════════════════════════════
			for /f "tokens=*" %%i in (%1) DO (
				echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefYedek%\%TarihVeSaat%\%%i"
				set /A "SayacYedek=!SayacYedek!+1"
			)
			echo.════════════════════════════════════════════════════════════
			echo TRANSFER...
			echo.════════════════════════════════════════════════════════════
				for /f "tokens=*" %%i in (%1) DO (
					echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefOtomasyon%\%%i"
					set /A "SayacTransfer=!SayacTransfer!+1"
				)
			REM YEDEK UZUNLUK
			set "YedekUzunluk=0"
			if not defined SayacYedek goto YedekUzunlukSonucClass
			:YedekUzunlukClass
			if not "!SayacYedek:~%YedekUzunluk%,1!" == "" (
				set /A YedekUzunluk+=1
				goto YedekUzunlukClass
			)
			:YedekUzunlukSonucClass	
			set /a "TOPLAMSONUC1=0"
			set /a "sCount1=%TRANSFERSINIR%-%YedekUzunluk%"
			for /l %%a in (1,1,%sCount1%) do call set "TOPLAMSONUC1=%%TOPLAMSONUC1%% "
			
			REM TRANSFER UZUNLUK
			set "TransferUzunluk=0"
			if not defined SayacTransfer goto TransferUzunlukSonucClass
			:TransferUzunlukClass
			if not "!SayacTransfer:~%TransferUzunluk%,1!" == "" (
				set /A TransferUzunluk+=1
				goto TransferUzunlukClass
			)
			:TransferUzunlukSonucClass
			set /a "TOPLAMSONUC2=0"
			set /a "sCount2=%TRANSFERSINIR%-%TransferUzunluk%"
			for /l %%a in (1,1,%sCount2%) do call set "TOPLAMSONUC2=%%TOPLAMSONUC2%% "
		
			cls
			call :color %ARKARENK%
			echo.╔═══════════════════════════════════════════════════════════╗
			echo.║╔═════════════════════════════════════════════════════════╗║
			echo.║║╔═══════════════════════════════════════════════════════╗║║
			echo ║║║ » Toplam Transfer Edilen = Yedek    = !SayacYedek! Dosya %TOPLAMSONUC1:~2% ║║║
			echo ║║║ » Toplam Transfer Edilen = Transfer = !SayacTransfer! Dosya %TOPLAMSONUC2:~2% ║║║
			echo.║║╚═══════════════════════════════════════════════════════╝║║
			echo.║╚═════════════════════════════════════════════════════════╝║
			echo.╚═══════════════════════════════════════════════════════════╝
		)
		goto Anasayfa

:TestServerdanOtomasyonPano
	set /A "SayacYedek=0"
	set /A "SayacTransfer=0"
	set /A "TRANSFERSINIR=9"
	echo.════════════════════════════════════════════════════════════
	for %%i in (powershell.exe) do if "%%~$path:i" neq "" (
    set getclip=powershell "Add-Type -AssemblyName System.Windows.Forms;$tb=New-Object System.Windows.Forms.TextBox;$tb.Multiline=$true;$tb.Paste();$tb.Text"
	) else (
		set getclip=%temp%\getclip.exe
		>"%temp%\c.cs" echo using System;using System.Threading;using System.Windows.Forms;class dummy{[STAThread]
		>>"%temp%\c.cs" echo public static void Main^(^){if^(Clipboard.ContainsText^(^)^) Console.Write^(Clipboard.GetText^(^)^);}}
		for /f "delims=" %%i in ('dir /b /s "%windir%\microsoft.net\*csc.exe"') do (
			if not exist "!getclip!" "%%i" /nologo /out:"!getclip!" "%temp%\c.cs" 2>NUL
		)
		del "%temp%\c.cs"
		if not exist "!getclip!" (
			echo Error: Please install .NET 2.0 or newer, or install PowerShell.
			goto :EOF
		)
	)
	echo YEDEK...
	echo.════════════════════════════════════════════════════════════
	for /f "delims=" %%i in ('%getclip% ^| findstr /n "^"') do (
		set "line=%%i" & set "line=!line:*:=!"
		if "!line!"=="" (echo !line! | echo Dosya veya dizin yok) else (
			echo f | xcopy /f /y "%HedefOtomasyon%\!line!" "%HedefYedek%\%TarihVeSaat%\!line!"
			set /A "SayacYedek=!SayacYedek!+1"
		)
	)
	echo.════════════════════════════════════════════════════════════
	echo TRANSFER...
	echo.════════════════════════════════════════════════════════════
	for /f "delims=" %%i in ('%getclip% ^| findstr /n "^"') do (
		set "line=%%i" & set "line=!line:*:=!"
		if "!line!"=="" (echo !line! | echo Dosya veya dizin yok) else (
			echo f | xcopy /f /y "%HedefTestServer%\!line!" "%HedefOtomasyon%\!line!"
			set /A "SayacTransfer=!SayacTransfer!+1"
		)
	)
	
	for /f "delims=" %%i in ('%getclip% ^| findstr /n "^"') do (
		set "line=%%i" & set "line=!line:*:=!"
		echo !line!
	)>> %HedefYedek%\%TarihVeSaat%\%TarihVeSaat%.txt
			REM YEDEK UZUNLUK
			set "YedekUzunluk=0"
			if not defined SayacYedek goto YedekUzunlukSonucClass
			:YedekUzunlukClass
			if not "!SayacYedek:~%YedekUzunluk%,1!" == "" (
				set /A YedekUzunluk+=1
				goto YedekUzunlukClass
			)
			:YedekUzunlukSonucClass	
			set /a "TOPLAMSONUC1=0"
			set /a "sCount1=%TRANSFERSINIR%-%YedekUzunluk%"
			for /l %%a in (1,1,%sCount1%) do call set "TOPLAMSONUC1=%%TOPLAMSONUC1%% "
			
			REM TRANSFER UZUNLUK
			set "TransferUzunluk=0"
			if not defined SayacTransfer goto TransferUzunlukSonucClass
			:TransferUzunlukClass
			if not "!SayacTransfer:~%TransferUzunluk%,1!" == "" (
				set /A TransferUzunluk+=1
				goto TransferUzunlukClass
			)
			:TransferUzunlukSonucClass
			set /a "TOPLAMSONUC2=0"
			set /a "sCount2=%TRANSFERSINIR%-%TransferUzunluk%"
			for /l %%a in (1,1,%sCount2%) do call set "TOPLAMSONUC2=%%TOPLAMSONUC2%% "
			
			cls
			call :color %ARKARENK%
			echo.╔═══════════════════════════════════════════════════════════╗
			echo.║╔═════════════════════════════════════════════════════════╗║
			echo.║║╔═══════════════════════════════════════════════════════╗║║
			echo ║║║ » Toplam Transfer Edilen = Yedek    = !SayacYedek! Dosya %TOPLAMSONUC1:~2% ║║║
			echo ║║║ » Toplam Transfer Edilen = Transfer = !SayacTransfer! Dosya %TOPLAMSONUC2:~2% ║║║
			echo.║║╚═══════════════════════════════════════════════════════╝║║
			echo.║╚═════════════════════════════════════════════════════════╝║
			echo.╚═══════════════════════════════════════════════════════════╝
	goto Anasayfa
	
:TestServerdanMasaustu
	echo.════════════════════════════════════════════════════════════
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo TRANSFER...
	mkdir %HedefMasaustu%\%TarihVeSaat%
	echo.════════════════════════════════════════════════════════════
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefMasaustu%\%TarihVeSaat%\%%i"
		)
	echo.════════════════════════════════════════════════════════════
	goto Anasayfa

:TestServerdanOtomasyon
	echo.════════════════════════════════════════════════════════════
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo YEDEK...
	echo.════════════════════════════════════════════════════════════
	echo.
	for /f "tokens=*" %%i in (%KaynakTxt%) DO (
		echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefYedek%\%TarihVeSaat%\%%i"
	)
	echo.════════════════════════════════════════════════════════════
	echo TRANSFER...
	echo.════════════════════════════════════════════════════════════
	echo.
	for /f "tokens=*" %%i in (%KaynakTxt%) DO (
		echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefOtomasyon%\%%i"
	)
	echo.════════════════════════════════════════════════════════════
	goto Anasayfa

:OtomasyondanMasaustu
	echo.════════════════════════════════════════════════════════════
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo TRANSFER...
	mkdir %HedefMasaustu%\%TarihVeSaat%
	echo.════════════════════════════════════════════════════════════
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefMasaustu%\%TarihVeSaat%\%%i"
		)
	echo.════════════════════════════════════════════════════════════
	goto Anasayfa

:OtomasyondanTestServer
	echo.════════════════════════════════════════════════════════════
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo YEDEK...
	echo.════════════════════════════════════════════════════════════
	echo.
	for /f "tokens=*" %%i in (%KaynakTxt%) DO (
		echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefYedek%\%TarihVeSaat%\%%i"
	)
	echo TRANSFER...
	echo.════════════════════════════════════════════════════════════
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefTestServer%\%%i"
		)
	echo.════════════════════════════════════════════════════════════
	goto Anasayfa
	
:Cikis
	echo.════════════════════════════════════════════════════════════
	echo.
	echo Programdan Cikiliyor...
	timeout /t 0
	exit

:color
@echo off
IF [%ESC%] == [] for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
SET color=0%1
IF [%color%] == [0] SET color=07
SET fore=%color:~-1%
SET back=%color:~-2,1% 
SET color=%ESC%[
if %fore% LEQ 7 (
  if %fore% == 0 SET color=%ESC%[30
  if %fore% == 1 SET color=%ESC%[34
  if %fore% == 2 SET color=%ESC%[32
  if %fore% == 3 SET color=%ESC%[36
  if %fore% == 4 SET color=%ESC%[31
  if %fore% == 5 SET color=%ESC%[35
  if %fore% == 6 SET color=%ESC%[33
  if %fore% == 7 SET color=%ESC%[37
) ELSE (
  if %fore% == 8 SET color=%ESC%[90
  if %fore% == 9  SET color=%ESC%[94
  if /i %fore% == a SET color=%ESC%[92
  if /i %fore% == b SET color=%ESC%[96
  if /i %fore% == c SET color=%ESC%[91
  if /i %fore% == d SET color=%ESC%[95
  if /i %fore% == e SET color=%ESC%[93
  if /i %fore% == f SET color=%ESC%[97
)
if %back% == 0 (SET color=%color%;40) ELSE (
  if %back% == 1 SET color=%color%;44
  if %back% == 2 SET color=%color%;42
  if %back% == 3 SET color=%color%;46
  if %back% == 4 SET color=%color%;41
  if %back% == 5 SET color=%color%;45
  if %back% == 6 SET color=%color%;43
  if %back% == 7 SET color=%color%;47
  if %back% == 8 SET color=%color%;100
  if %back% == 9  SET color=%color%;104
  if /i %back% == a SET color=%color%;102
  if /i %back% == b SET color=%color%;106
  if /i %back% == c SET color=%color%;101
  if /i %back% == d SET color=%color%;105
  if /i %back% == e SET color=%color%;103
  if /i %back% == f SET color=%color%;107
)
SET color=%color%m
:repeatcolor
if [%2] NEQ [$] SET color=%color%%~2
shift
if [%2] NEQ [] if [%2] NEQ [$] SET color=%color% & goto :repeatcolor
if [%2] EQU [$] (echo %color%) else (<nul set /p ="%color%")
goto :eof
