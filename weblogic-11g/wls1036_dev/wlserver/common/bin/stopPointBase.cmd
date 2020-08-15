@ECHO OFF
@SETLOCAL

SET WL_HOME=C:\weblogic\src1036_16029jr\bea\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

@REM Add PointBase classes to the classpath
SET CLASSPATH=%POINTBASE_CLASSPATH%;%POINTBASE_TOOLS%

GOTO :SETDEFAULTS

:SETDEFAULTS
SET SCRIPT_NAME=%0
SET HOST=localhost
SET PORT=9093
SET DBNAME=demo
SET USERNAME=PBSYSADMIN
SET PASSWORD=PBSYSADMIN
GOTO :PARSEARGS


:PARSEARGS
SET VALIDATE=%2
FOR %%I IN (%VALIDATE%) DO SET VALIDATE=%%~I
if NOT {%1}=={} (
  IF "%VALIDATE:~0,1%"=="-" (
    ECHO ERROR! Missing equal^(=^) sign. Arguments must be -name=value!
    GOTO :USAGE
  )
  IF "%VALIDATE%"=="" (
    ECHO ERROR! Missing value! Arguments must be -name=value!
    GOTO :USAGE
  )
  GOTO :SETARG
) ELSE (
  GOTO :RUN
)

:SETARG
SET ARGNAME=%1
SET ARGVALUE=%2
SHIFT
SHIFT
FOR %%I IN (%ARGVALUE%) DO SET ARGVALUE=%%~I
IF /i "%ARGNAME%"=="-port" (
  SET PORT=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-host" (
  SET HOST=%ARGVALUE%
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-name" (
  SET DBNAME=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-user" (
  SET USERNAME=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-pass" (
  SET PASSWORD=%ARGVALUE%
  GOTO :PARSEARGS
) ELSE (
  ECHO UNKNOWN SWITCH %ARGNAME%!
  GOTO :USAGE
)

:RUN
ECHO SHUTDOWN FORCE; | "%JAVA_HOME%\bin\java" com.pointbase.tools.toolsCommander com.pointbase.jdbc.jdbcUniversalDriver jdbc:pointbase:server://%HOST%:%PORT%/%DBNAME% %USERNAME% %PASSWORD%
GOTO :EOF


:USAGE
ECHO ========================================================
ECHO  USAGE:
ECHO    VALID SWITCHES:
ECHO      -port=The PointBase Server's port.^(default=9093^)
ECHO .
ECHO      -host=The PointBase Server's host name.^(default=localhost^)
ECHO .
ECHO      -name=The PointBase Server's database name.^(default=demo^)
ECHO .
ECHO      -user=The PointBase Server's user name.^(default=PBSYSADMIN^)
ECHO .
ECHO      -pass=The PointBase Server's password.^(default=PBSYSADMIN^)
ECHO .
ECHO EXAMPLE:
ECHO %SCRIPT_NAME% -port=9093 -host=localhost -name=platform
ECHO ========================================================

@ENDLOCAL
