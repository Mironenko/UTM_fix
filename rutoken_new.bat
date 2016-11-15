@echo off

cd %SystemRoot%
cd ..

set arch=%PROCESSOR_ARCHITECTURE%
if "%arch%" == "AMD64" (
  set sysarch=SysWOW64
) else (
  set sysarch=System32
)

set system_root_linux_style=%SystemRoot:\=/%
set system_root_cpp_style=%SystemRoot:\=\\%

echo "Creating rtPKCS11ECP-replica.dll..."
copy /y %system_root_cpp_style%\%sysarch%\rtPKCS11ECP.dll %system_root_cpp_style%\%sysarch%\rtPKCS11ECP-replica.dll > nul


set pin_pki=crypto.lib.pki.keystorePassword
set pin_pki2=crypto.lib.pki.keyPassword
set pin_gost=crypto.lib.gost.keystorePassword
set pin_gost2=crypto.lib.gost.keyPassword
set rsa=rsa.library.path
set gost=gost.library.path


set verfile=..\UTM\agent\conf\agent.properties
set tempfile=%verfile%.tmp
set backupfile=%verfile%.backup

echo "Processing "%verfile%
copy /y %verfile% %backupfile% > nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%system_root_linux_style%/%sysarch%/rtPKCS11ECP-replica.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%gost%="&&((echo %gost%=%system_root_cpp_style%\\%sysarch%\\rttranscrypt.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul


rem ---------------------------------------------------

set verfile=..\UTM\installer\conf\transport.properties
set tempfile=%verfile%.tmp
set backupfile=%verfile%.backup

echo "Processing "%verfile%
copy /y %verfile% %backupfile% > nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%gost%="&&((echo %gost%=%system_root_cpp_style%\\%sysarch%\\rttranscrypt.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%system_root_cpp_style%\\%sysarch%\\rtPKCS11ECP-replica.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul


rem ---------------------------------------------------

set verfile=..\UTM\monitoring\conf\transport.properties
set tempfile=%verfile%.tmp
set backupfile=%verfile%.backup

echo "Processing "%verfile%
copy /y %verfile% %backupfile% > nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki2%="&&((echo %pin_pki2%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki2%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%system_root_cpp_style%\\%sysarch%\\rtPKCS11ECP-replica.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul


rem ---------------------------------------------------

set verfile=..\UTM\transporter\conf\transport.properties
set tempfile=%verfile%.tmp
set backupfile=%verfile%.backup

echo "Processing "%verfile%
copy /y %verfile% %backupfile% > nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_gost2%="&&((echo %pin_gost2%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_gost2%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki2%="&&((echo %pin_pki2%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki2%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%system_root_cpp_style%\\%sysarch%\\rtPKCS11ECP-replica.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

if exist %tempfile4% del /q %tempfile%
for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%gost%="&&((echo %gost%=%system_root_cpp_style%\\%sysarch%\\rttranscrypt.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul


rem ---------------------------------------------------

set verfile=..\UTM\updater\conf\transport.properties
set tempfile=%verfile%.tmp
set backupfile=%verfile%.backup

echo "Processing "%verfile%
copy /y %verfile% %backupfile% > nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_pki%="&&((echo %pin_pki%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_pki%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%pin_gost%="&&((echo %pin_gost%=%1)>>%tempfile%)
  (echo "%%a")|>nul find /i "%pin_gost%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul

for /f "delims=" %%a in (%verfile%) do (
  (echo "%%a")|>nul find /i "%rsa%="&&((echo %rsa%=%system_root_cpp_style%\\%sysarch%\\rtPKCS11ECP-replica.dll)>>%tempfile%)
  (echo "%%a")|>nul find /i "%rsa%="||(echo %%a)>>%tempfile%
)
move /y %tempfile% %verfile% >nul
