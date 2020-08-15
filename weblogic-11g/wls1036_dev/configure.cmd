@echo off
@rem ***************************************************************************
@rem This script is used to setup certain artifacts in a zip distribution after 
@rem the extraction process. This script has to be rerun whenever the target 
@rem location is moved to another folder or machine
@rem
@rem JAVA_HOME and MW_HOME need to be configured prior to invoking this script
@rem ***************************************************************************


if not defined MW_HOME (
  echo "ERROR: You must set MW_HOME and it must point to a directory".
  echo "       where an installation of WebLogic exists. Ensure you point "
  echo "       this variable to the extract location of the zip distribution."
  goto finish
)

if not defined JAVA_HOME (
  echo "ERROR: You must set JAVA_HOME and point it to a valid location"
  echo "       of where your JDK has been installed"
  goto finish
)

@echo "Setting up proper ACLs for %MW_HOME% ... (operation takes awhile)"
echo Y|cacls %MW_HOME% /G administrators:F "creator owner":F system:F %USERDOMAIN%\%USERNAME%:F /T > NUL

@rem
@rem Setup the environment
@rem
call "%MW_HOME%\wlserver\server\bin\setWLSEnv.cmd"

@rem 
@rem Generate the .product.properties and the registry.xml
@rem 
%JAVA_HOME%\bin\java.exe -Dant.home=%MW_HOME%\modules\org.apache.ant_1.7.1 org.apache.tools.ant.Main -f %MW_HOME%\configure.xml 

:finish
