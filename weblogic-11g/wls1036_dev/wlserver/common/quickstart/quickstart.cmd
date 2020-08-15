@ECHO OFF
SETLOCAL

"%MW_HOME%\utils\quickstart\quickstart.cmd" install.dir="%MW_HOME%\wlserver" product.alias.id="@PROD_ALIAS_ID" product.alias.version="@PROD_ALIAS_VERSION" %*

EXIT /B %ERRORLEVEL%

ENDLOCAL  
