@ECHO OFF
@SETLOCAL

SET WL_HOME=C:\weblogic\src1036_16029jr\bea\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

@REM Add PointBase classes to the classpath
SET CLASSPATH=%POINTBASE_CLASSPATH%;%WEBLOGIC_CLASSPATH%

IF NOT "%DOMAIN_HOME%"=="" (
  SET CLASSPATH=%CLASSPATH%;%DOMAIN_HOME%
)

GOTO :SETDEFAULTS

:SETDEFAULTS
SET SCRIPT_NAME=%0
SET PORT=9092
SET DEBUG=0
SET POINTBASE_INI=%WL_HOME%\common\eval\pointbase\tools\pointbase.ini
SET DBHOME=%WL_HOME%/common/eval/pointbase/databases
SET DOCS=%WL_HOME%/common/eval/pointbase/docs
SET LICENSE=%WL_HOME%/common/eval/pointbase/lib/pbembedded.lic
SET ISOLEVEL=TRANSACTION_READ_COMMITTED
SET PAGESIZE=8192
SET CACHESIZE=2063
SET SORTSIZE=1024
SET WAIT=false
SET CONSOLE=
SET SERVERWINDOW=
SET LOGFILE=
SET BACKGROUND=false
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
IF /i "%ARGNAME%"=="-debug" (
  SET DEBUG=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-ini" (
  SET INI=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-home" (
  SET DBHOME=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-doc" (
  SET DOCS=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-isolevel" (
  SET ISOLEVEL=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-pagesize" (
  SET PAGESIZE=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-cache" (
  SET CACHESIZE=%ARGVALUE%
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-sort" (
  SET SORTSIZE=%ARGVALUE%
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-log" (
  SET LOGFILE=/file:%ARGVALUE%
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-console" (
  IF /i "%ARGVALUE%"=="true" (
    SET CONSOLE=
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      SET CONSOLE=/noconsole
    ) ELSE (
      ECHO UNKNOWN -console OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-win" (
  IF /i "%ARGVALUE%"=="true" (
    SET SERVERWINDOW=/win
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      SET SERVERWINDOW=
    ) ELSE (
      ECHO UNKNOWN -win OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-background" (
  IF /i "%ARGVALUE%"=="true" (
    SET BACKGROUND=true
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      SET BACKGROUND=false
    ) ELSE (
      ECHO UNKNOWN -background OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-wait" (
  IF /i "%ARGVALUE%"=="true" (
    SET WAIT=%ARGVALUE%
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      SET WAIT=%ARGVALUE%
    ) ELSE (
      ECHO UNKNOWN -wait OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
) ELSE (
  ECHO UNKNOWN SWITCH %ARGNAME%!
  GOTO :USAGE
)


:RUN
IF NOT EXIST "%INI%" (
  @ECHO database.home=%DBHOME% > %POINTBASE_INI%
  @ECHO documentation.home=%DOCS% >> %POINTBASE_INI%
  @ECHO pbembedded.lic=%LICENSE% >> %POINTBASE_INI%
  @ECHO transaction.isolationlevel=%ISOLEVEL% >> %POINTBASE_INI%
  @ECHO database.pagesize=%PAGESIZE% >> %POINTBASE_INI%
  @ECHO cache.size=%CACHESIZE% >> %POINTBASE_INI%
  @ECHO sort.size=%SORTSIZE% >> %POINTBASE_INI%
) ELSE (
  SET POINTBASE_INI=%INI%
)

IF "%BACKGROUND%"=="true" (
  %WL_HOME%\common\bin\console.exe /background "%JAVA_HOME%\bin\java" com.pointbase.net.netServer %CONSOLE% %SERVERWINDOW% %LOGFILE% /port:%PORT% /d:%DEBUG% /pointbase.ini="%POINTBASE_INI%"
) ELSE (
  IF "%WAIT%"=="false" (
    START "PointBase Server" CMD /S /C ""%JAVA_HOME%\bin\java" com.pointbase.net.netServer %CONSOLE% %SERVERWINDOW% %LOGFILE% /port:%PORT% /d:%DEBUG% /pointbase.ini="%POINTBASE_INI%""
  ) ELSE (
    "%JAVA_HOME%\bin\java" com.pointbase.net.netServer %CONSOLE% %SERVERWINDOW% %LOGFILE% /port:%PORT% /d:%DEBUG% /pointbase.ini="%POINTBASE_INI%"
  )
)

GOTO :EOF


:USAGE
ECHO ========================================================
ECHO  USAGE:
ECHO    VALID SWITCHES:
ECHO      -port=The port to start the PointBase Server on.^(default=9092^)
ECHO .
ECHO      -debug=The PointBase Server debug level ^(range:0-3^).^(default=0^)
ECHO .
ECHO      -wait="true" or "false" Sets if this script will wait for the server
ECHO             process to exit or start the server in a seperate window.
ECHO             ^(default=false^)
ECHO .
ECHO      -background="true" or "false" Sets if the pointbase server will be 
ECHO             launched as a background process. This option forces -wait, 
ECHO             -console, and -win to be false.^(default=false^)
ECHO .
ECHO      -console="true" or "false" Sets if console interaction is available
ECHO             in the server window.^(default=true^)
ECHO .
ECHO      -win="true" or "false" Sets if then the PointBase server status
ECHO             GUI window will be displayed.^(default=false^) 
ECHO             NOTE: This overrides -console option!
ECHO .
ECHO      -log=The PointBase log file. ^(default=No Log File^)
ECHO .
ECHO      -ini=The pointbase.ini file. If set then no other switches are needed!!
ECHO            If not set, then a pointbase.ini file is created 
ECHO            by this script. It is located at:
ECHO            "%WL_HOME%\common\eval\pointbase\tools\pointbase.ini"
ECHO            and uses the switches below for its values.
ECHO .
ECHO      -home=The PointBase home directory.
ECHO        ^(default=%WL_HOME%/common/eval/pointbase/databases^)
ECHO .
ECHO      -doc=The PointBase docs directory.
ECHO        ^(default=%WL_HOME%/common/eval/pointbase/docs^)
ECHO .
ECHO      -isolevel=The transaction isolation level.
ECHO        ^(default=TRANSACTION_READ_COMMITTED^)
ECHO .
ECHO      -pagesize=The page size.^(default=8192^)
ECHO .
ECHO      -cache=The cache size.^(default=2063^)
ECHO .
ECHO      -sort=The sort size.^(default=1024^)
ECHO .
ECHO EXAMPLE:
ECHO %SCRIPT_NAME% -port=9092 -debug=3
ECHO ========================================================

@ENDLOCAL
