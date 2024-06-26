@ECHO OFF
@REM
@REM Additional commands to support node manager ip migration. 
@REM Requires netsh.exe.
@REM
SETLOCAL

SET CONFIG=WLIFCFG.DAT
SET IFNAME=%2
SET SERVER_IP=%3
SET IPMASK=%4
SET GATEWAY=%5
SET GWMETRIC=%6

IF "%1"=="-addif" GOTO ADDIF
IF "%1"=="-removeif" GOTO REMOVEIF
IF "%1"=="-listif" GOTO LISTIF

GOTO END

@REM
@REM Prints out list of available network interfaces.
@REM
:LISTIF
NETSH INTERFACE IP SHOW CONFIG
GOTO END

@REM
@REM Set local static IP address.
@REM
:ADDIF
NETSH INTERFACE DUMP > %CONFIG%
NETSH INTERFACE IP SET ADDRESS %IFNAME% STATIC %SERVER_IP% %IPMASK% %GATEWAY% %GWMETRIC%
GOTO END

@REM
@REM Reset original config
@REM
:REMOVEIF
IF EXIST %CONFIG% NETSH EXEC %CONFIG%
GOTO END

:END
ENDLOCAL
