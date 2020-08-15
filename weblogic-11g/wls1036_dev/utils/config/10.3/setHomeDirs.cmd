set MW_HOME=%MW_HOME%
FOR %%i IN ("%MW_HOME%") DO SET MW_HOME=%%~fsi
set WL_HOME=%MW_HOME%\wlserver
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
