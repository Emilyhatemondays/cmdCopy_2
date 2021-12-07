@echo off
	REM chcp 1252
	color 02
	mode con cols=60 lines=25
	title TXT LIST FILE TRANSFER ^| Jokedr
	REM fltmc >nul 2>&1 || (
	  REM echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\GetAdmin.vbs"
	  REM echo UAC.ShellExecute "%~fs0", "", "", "runas", 1 >> "%temp%\GetAdmin.vbs"
	  REM cmd /u /c type "%temp%\GetAdmin.vbs">"%temp%\GetAdminUnicode.vbs"
	  REM cscript //nologo "%temp%\GetAdminUnicode.vbs"
	  REM del /f /q "%temp%\GetAdmin.vbs" >nul 2>&1
	  REM del /f /q "%temp%\GetAdminUnicode.vbs" >nul 2>&1
	  REM exit
	REM )
	set HedefTestServer=\\TESTSERVER\testserver
	set HedefOtomasyon=\\OTOMASYON\wwwroot\otomasyon
	set HedefMasaustu=%USERPROFILE%\Desktop
	
:Anasayfa
	echo.
	echo.== TXT LIST FILE TRANSFER =================================
	echo 1. TestServer - Masaustu Kopyala
	echo 2. TestServer - Otomasyon Kopyala
	echo 3. Otomasyon - Masaustu Kopyala
	echo 4. Otomasyon - TestServer Kopyala
	echo 5. Cikis
	echo.===========================================================
	echo.
	choice /N /C:12345 /M "Yapacaginiz Islemi Seciniz (1,2,3,4 veya 5)"%1
	echo.

	if errorlevel ==5 goto Cikis
	if errorlevel ==4 goto OtomasyondanTestServer
	if errorlevel ==3 goto OtomasyondanMasaustu
	if errorlevel ==2 goto TestServerdanOtomasyon
	if errorlevel ==1 goto TestServerdanMasaustu	

:TestServerdanMasaustu
	echo.===========================================================
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo %KaynakTxt%
	echo.===========================================================
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefMasaustu%\%%i"
		)
	echo.===========================================================
	goto Anasayfa

:TestServerdanOtomasyon
	echo.===========================================================
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo %KaynakTxt%
	echo.===========================================================
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefTestServer%\%%i" "%HedefOtomasyon%\%%i"
		)
	echo.===========================================================
	goto Anasayfa

:OtomasyondanMasaustu
	echo.===========================================================
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo %KaynakTxt%
	echo.===========================================================
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefMasaustu%\%%i"
		)
	echo.===========================================================
	goto Anasayfa

:OtomasyondanTestServer
	echo.===========================================================
	for /F "tokens=2-4 delims=/ " %%i in ('date /t') do set yyyymmdd=%%k%%j%%i
	set dialog="about:<input type=file id=FILE><script>FILE.click();new ActiveXObject
	set dialog=%dialog%('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(FILE.value);
	set dialog=%dialog%close();resizeTo(0,0);</script>"
	for /f "tokens=* delims=" %%p in ('mshta.exe %dialog%') do set "KaynakTxt=%%p"
	echo %KaynakTxt%
	echo.===========================================================
	echo.
		for /f "tokens=*" %%i in (%KaynakTxt%) DO (
			echo f | xcopy /f /y "%HedefOtomasyon%\%%i" "%HedefTestServer%\%%i"
		)
	echo.===========================================================
	goto Anasayfa

:Cikis
	echo.===========================================================
	echo.
	echo Programdan Cikiliyor...
	timeout /t 2
	exit
