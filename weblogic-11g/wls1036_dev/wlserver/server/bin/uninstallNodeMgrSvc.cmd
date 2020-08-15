@rem *************************************************************************
@rem This script is used to uninstall a NodeManager Windows Service.
@rem
@rem This script sets the following variables before uninstalling 
@rem the Windows Service:
@rem
@rem WL_HOME    - The root directory of your WebLogic installation
@rem *************************************************************************

@echo off
SETLOCAL

set WL_HOME=%MW_HOME%\wlserver
set PROD_NAME=@PROD_NAME
set BAR_WL_HOME=@BAR_WL_HOME

rem *** Uninstall the service
"%WL_HOME%\server\bin\beasvc" -remove -svcname:"%PROD_NAME% NodeManager (%BAR_WL_HOME%)"

ENDLOCAL

