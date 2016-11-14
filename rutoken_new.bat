@echo off

cd %SystemRoot%
cd ..

set arch=%PROCESSOR_ARCHITECTURE%
if "%arch%" == "AMD64" (
	set sysarch=SysWOW64
) else (
	set sysarch=System32
)

set path_rsa=%SystemRoot:\=/%
set path_rsa2=%SystemRoot:\=\\%
set path_gost=%SystemRoot:\=\\%

set verfile=..\UTM\agent\conf\agent.properties
set tmpfile=..\UTM\agent\conf\agent.properties.tmp
set verfile2=..\UTM\installer\conf\transport.properties
set tmpfile2=..\UTM\installer\conf\transport.properties.tmp
set verfile3=..\UTM\monitoring\conf\transport.properties
set tmpfile3=..\UTM\monitoring\conf\transport.properties.tmp
set verfile4=..\UTM\transporter\conf\transport.properties
set tmpfile4=..\UTM\transporter\conf\transport.properties.tmp
set verfile5=..\UTM\updater\conf\transport.properties
set tmpfile5=..\UTM\updater\conf\transport.properties.tmp

set pin_pki=crypto.lib.pki.keystorePassword
set pin_pki2=crypto.lib.pki.keyPassword
set pin_gost=crypto.lib.gost.keystorePassword
set pin_gost2=crypto.lib.gost.keyPassword
set rsa=rsa.library.path
set gost=gost.library.path


echo Please wait...

rem IPs
for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tmpfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tmpfile%
)
copy /y %tmpfile% %verfile% >nul
del /f /q %tmpfile% >nul

for /f "delims=" %%a in (%verfile2%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tmpfile2%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tmpfile2%
)
copy /y %tmpfile2% %verfile2% >nul
del /f /q %tmpfile2% >nul

for /f "delims=" %%a in (%verfile2%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tmpfile2%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tmpfile2%
)
copy /y %tmpfile2% %verfile2% >nul
del /f /q %tmpfile2% >nul

for /f "delims=" %%a in (%verfile3%) do (
  (echo "%%a")|>nul find /i "%pin_pki2%="&&((echo %pin_pki2%=%1)>>%tmpfile3%)
  (echo "%%a")|>nul find /i "%pin_pki2%="||(echo %%a)>>%tmpfile3%
)
copy /y %tmpfile3% %verfile3% >nul
del /f /q %tmpfile3% >nul

for /f "delims=" %%a in (%verfile3%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tmpfile3%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tmpfile3%
)
copy /y %tmpfile3% %verfile3% >nul
del /f /q %tmpfile3% >nul

for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%pin_gost2%="&&((echo %pin_gost2%=%1)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%pin_gost2%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%pin_pki2%="&&((echo %pin_pki2%=%1)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%pin_pki2%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

for /f "delims=" %%a in (%verfile5%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tmpfile5%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tmpfile5%
)
copy /y %tmpfile5% %verfile5% >nul
del /f /q %tmpfile5% >nul

for /f "delims=" %%a in (%verfile5%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tmpfile5%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tmpfile5%
)
copy /y %tmpfile5% %verfile5% >nul
del /f /q %tmpfile5% >nul


rem DDLs
if exist %tmpfile% del /q %tmpfile%
for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%path_rsa%/%sysarch%/rtPKCS11ECP.dll)>>%tmpfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tmpfile%
)
copy /y %tmpfile% %verfile% >nul
del /f /q %tmpfile% >nul

if exist %tmpfile2% del /q %tmpfile2%
for /f "delims=" %%a in (%verfile2%) do (
  (echo "%%a")|>nul find /i "%gost%="&&((echo %gost%=%path_gost%\\%sysarch%\\rttranscrypt.dll)>>%tmpfile2%)
  (echo "%%a")|>nul find /i "%gost%="||(echo %%a)>>%tmpfile2%
)
copy /y %tmpfile2% %verfile2% >nul
del /f /q %tmpfile2% >nul

if exist %tmpfile2% del /q %tmpfile2%
for /f "delims=" %%a in (%verfile2%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%path_rsa2%\\%sysarch%\\rtPKCS11ECP.dll)>>%tmpfile2%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tmpfile2%
)
copy /y %tmpfile2% %verfile2% >nul
del /f /q %tmpfile2% >nul

if exist %tmpfile3% del /q %tmpfile3%
for /f "delims=" %%a in (%verfile3%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%path_rsa2%\\%sysarch%\\rtPKCS11ECP.dll)>>%tmpfile3%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tmpfile3%
)
copy /y %tmpfile3% %verfile3% >nul
del /f /q %tmpfile3% >nul

if exist %tmpfile4% del /q %tmpfile4%
for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%path_rsa2%\\%sysarch%\\rtPKCS11ECP.dll)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

if exist %tmpfile4% del /q %tmpfile4%
for /f "delims=" %%a in (%verfile4%) do (
  (echo "%%a")|>nul find /i "%gost%="&&((echo %gost%=%path_gost%\\%sysarch%\\rttranscrypt.dll)>>%tmpfile4%)
  (echo "%%a")|>nul find /i "%gost%="||(echo %%a)>>%tmpfile4%
)
copy /y %tmpfile4% %verfile4% >nul
del /f /q %tmpfile4% >nul

if exist %tmpfile5% del /q %tmpfile5%
for /f "delims=" %%a in (%verfile5%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%path_rsa2%\\%sysarch%\\rtPKCS11ECP.dll)>>%tmpfile5%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tmpfile5%
)
copy /y %tmpfile5% %verfile5% >nul
del /f /q %tmpfile5% >nul

)
)