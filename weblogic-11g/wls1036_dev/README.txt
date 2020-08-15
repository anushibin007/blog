-------------------------------------------------------------------------------
          WLS Zip Distribution for Oracle WebLogic Server 10.3.6.0
-------------------------------------------------------------------------------

The WLS zip distribution is intended for development use. It is supported on 
Windows, Linux and Mac OS X systems. It contains the necessary artifacts to 
develop and test applications on WebLogic Server.  

An optional supplemental zip (wls1036_dev_supplemental.zip) is 
available as a separate download. The supplemental zip contains samples, 
evaluation database (Derby) and L10N console help files. 

The following instructions should help in quickly setting up WLS. Please refer 
to the general WLS documentation for detailed instructions.

QUICKSTART
----------

1. Extract the contents of the zip to a directory. This directory is now the 
   MW_HOME (eg: /home/myhome/mywls)

2. Setup JAVA_HOME and MW_HOME variables in the current shell

  Linux
    $ export JAVA_HOME=/home/myhome/myjavahome
    $ export MW_HOME=/home/myhome/mywls

  Mac
    $ export JAVA_HOME=
      /System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
    $ export MW_HOME=/home/myhome/mywls

  Windows
    > set JAVA_HOME=C:\home\myhome\myjavahome
    > set MW_HOME=C:\home\myhome\mywls
    
    This version of WLS requires JDK 1.6. For Mac use 1.6.0_20 latest update. 
    Ensure that you have the proper JDK version installed.
   
 	
3. Run the installation configuration script in the MW_HOME directory
   (This step is required to be run only once. If you move the installation to 
    another location/machine, you need to rerun this step)

  Linux/Mac
    $ ./configure.sh 

  Windows
    > configure.cmd

  This step also sets the WLS environment for the current shell. So, the next
  step can be ommitted.

4. Setup WLS environment in the current shell. 

   Linux
    $ . $MW_HOME/wlserver/server/bin/setWLSEnv.sh 

   Mac
    $ export USER_MEM_ARGS="-Xmx1024m -XX:PermSize=256m"
    $ . $MW_HOME/wlserver/server/bin/setWLSEnv.sh 

   Windows
    > %MW_HOME%\wlserver\server\bin\setWLSEnv.cmd

5. Create a new WLS domain and start WLS.
   (It is recommended that you create the domains outside the MW_HOME)

   Linux
    $ mkdir /home/myhome/mydomain
    $ cd /home/myhome/mydomain
    $ $JAVA_HOME/bin/java -Xmx1024m -XX:MaxPermSize=128m weblogic.Server
    
   Mac
    $ mkdir /home/myhome/mydomain
    $ cd /home/myhome/mydomain
    $ $JAVA_HOME/bin/java -Xmx1024m -XX:MaxPermSize=256m weblogic.Server	
			
   Windows
    $ mkdir C:\home\myhome\mydomain
    $ cd C:\home\myhome\mydomain
    $ %JAVA_HOME%\bin\java.exe -Xmx1024m -XX:MaxPermSize=128m weblogic.Server

   Once the domain is created, you can shutdown WLS and restart it with the 
   scripts provided in the newly created domain. 
   
   Note: You can also create the domain by invoking the GUI configuration
   wizard (Run MW_HOME/wlserver/common/bin/config.[sh|cmd])

6. If you already have an existing domain that you want to run with this 
   installation, edit the DOMAIN_HOME/bin/setDomainEnv.sh script and change the 
   WL_HOME to point to the new installation - ${MW_HOME}/wlserver/

   Note: If the existing domain has samples configured, the server will issue
   failures during startup as samples are not included in the zip distribution.

7. Start a browser and open up url - 'http://localhost:7001/console' to 
   administer the server.
 
8. If you need samples, evaluation database (Derby) or console help files for
   for non-english locales, you can download the supplemental zip and extract 
   it under MW_HOME. Follow instructions in README_SUPP.txt to properly setup
   samples.

WHAT IS NOT INCLUDED
--------------------
The following components are not available in the zip distribution.

# Coherence libraries
# WebServer plugins
# Native JNI libraries for unsupported platforms
# Samples, evaluation database (Derby), non-english console help
  (can be added by using the WLS supplemental zip)

CLEANUP
-------
Delete the MW_HOME directory. Note that this will delete everything under
MW_HOME. If you have created domains or extracted supplemental zip those 
files will be removed as well. Ensure that you don't create domains or 
applications under MW_HOME directory for easier migration. 

UPGRADE
-------
In-place upgrade of installation is not supported in the zip distribution. 
Download the new version of zip distribution and extract it to a new location. 
Change the MW_HOME to point to the new location and update the startup scripts
in your domains to point to the new MW_HOME.

KNOWN ISSUES
------------
# [MAC OS X] Memory settings have to be explicitly defined using the 
  USER_MEM_ARGS variable prior to running any domain scripts.
# [MAC OS X] The config wizard does not recognize a Mac OS X JDK installation 
  and issues a warning. But, it successfully creates a domain and should not 
  cause any issue running servers in the domain.
# [MAC OS X] The zip distribution has limited support for functionality 
  requiring native support. JMS C clients, auto stack-dumps, auto privileged 
  port binding are not supported.
# [ALL OS] Smart update tool is not supported in a zip distribution.
# [ALL OS] The zip distribution should not be extracted to an existing MW_HOME
  or BEA_HOME which had been created by a regular installers. Doing so will
  conflict with already installed products and is unsupported.

PATCHING
--------
# As the smart update tool is not supported, patching has to be done manually.  
  Contact support for a patch jar and apply it manually to the classpath

