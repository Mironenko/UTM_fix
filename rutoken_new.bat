@echo off

setlocal enabledelayedexpansion

cd %SystemRoot%
cd ..

set sysarch=SysWOW64
set sysarch2=SysWOW64
if "%PROCESSOR_ARCHITECTURE%" == "x86" (
  if not defined PROCESSOR_ARCHITEW6432 set sysarch=System32
)

echo Detect system architecture, test1 - !sysarch!

if not exist %SystemRoot%\!sysarch2! set sysarch2=System32
echo Detect system architecture, test2 - !sysarch2!

if not "%sysarch%" == "%sysarch2%" set sysarch=!sysarch2!
echo Using system architecture - !sysarch!

set pin=%1
if "%pin%"=="" set pin=12345678
echo Using pin code - %pin%

set system_root_cpp_style=%SystemRoot:\=\\%

echo Creating rtPKCS11ECP-replica.dll...
if not exist %system_root_cpp_style%\!sysarch!\rtPKCS11ECP.dll (
    echo You should install Rutoken drivers first!
    exit /b
)

copy /y %system_root_cpp_style%\!sysarch!\rtPKCS11ECP.dll %system_root_cpp_style%\!sysarch!\rtPKCS11ECP-replica.dll > nul
%system_root_cpp_style%\!sysarch!\regsvr32.exe /s %system_root_cpp_style%\!sysarch!\rtPKCS11ECP-replica.dll > nul

if not "!sysarch!" == "System32" (
    echo Creating rtPKCS11ECP-replica.dll x86-64 version...
    set sysarch=System32
    set sysarch=!sysarch:~0,10!
    copy /y %system_root_cpp_style%\!sysarch!\rtPKCS11ECP.dll %system_root_cpp_style%\!sysarch!\rtPKCS11ECP-replica.dll > nul
    %system_root_cpp_style%\!sysarch!\regsvr32.exe /s %system_root_cpp_style%\!sysarch!\rtPKCS11ECP-replica.dll > nul
)

for %%i in (..\UTM\agent\conf\agent.properties
            ..\UTM\installer\conf\transport.properties
            ..\UTM\monitoring\conf\transport.properties
            ..\UTM\transporter\conf\transport.properties
            ) do (

    set verfile=%%i
    set tempfile=!verfile!.tmp
    set backupfile=!verfile!.backup

    echo Processing !verfile!
    if not exist !verfile! (
        echo You should run UTM at least once before running UTM_fix
        exit /b
    )

    copy /y !verfile! !backupfile! > nul

    call :patch_value !tempfile! !verfile! crypto.lib.pki.keystorePassword %pin%
    call :patch_value !tempfile! !verfile! crypto.lib.pki.keyPassword %pin%
    call :patch_value !tempfile! !verfile! crypto.lib.gost.keystorePassword %pin%
    call :patch_value !tempfile! !verfile! crypto.lib.gost.keyPassword %pin%

    call :patch_value !tempfile! !verfile! rsa.library.path %system_root_cpp_style%\\!sysarch!\\rtPKCS11ECP-replica.dll
    call :patch_value !tempfile! !verfile! gost.library.path %system_root_cpp_style%\\!sysarch!\\rttranscrypt.dll
)

echo Success
exit /b 0

:patch_value
    for /f "delims=" %%a in (%2) do (
        (echo "%%a")|>nul find /i "%3="&&((echo %3=%4)>>%1)
        (echo "%%a")|>nul find /i "%3="||(echo %%a)>>%1
    )
    move /y %1 %2 >nul
    exit /b 0
