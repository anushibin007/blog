#!/bin/sh


usage(){
  echo "========================================================"
  echo " USAGE:"
  echo "  VALID SWITCHES:"
  echo "    -port=The port to start the PointBase Server on.(default=9092)"
  echo ""
  echo "    -debug=The PointBase Server debug level.(default=0)"
  echo ""
  echo "    -wait=\"true\" or \"false\" Sets if this script will wait for the server"
  echo "           process to exit or start the server seperate.(default=false)"
  echo ""
  echo "    -background=\"true\" or \"false\" Not used on Unix use the -wait flag instead"
  echo ""
  echo "    -console=\"true\" or \"false\" Sets if console interaction is available"
  echo "           in the server window."
  echo "           (default=true if wait=true, always false if wait=false)"
  echo ""
  echo "    -win=\"true\" or \"false\" Sets if then the PointBase server status"
  echo "           GUI window will be displayed."
  echo "           (default=false if wait=true, always false if wait=false)"
  echo "           NOTE: This overrides -console option!"
  echo ""
  echo "    -log=The PointBase log file. (default=No Log File)"
  echo ""
  echo "    -ini=The pointbase.ini file. If set then no other switches are needed!!"
  echo "          If not set, then a pointbase.ini file is created"
  echo "          by this script. It is located at:"
  echo "          \"${WL_HOME}/common/eval/pointbase/tools/pointbase.ini\""
  echo "          and uses the switches below for its values."
  echo ""
  echo "    -home=The PointBase home directory."
  echo "      (default=${WL_HOME}/common/eval/pointbase/databases)"
  echo ""
  echo "    -doc=The PointBase docs directory."
  echo "      (default=${WL_HOME}/common/eval/pointbase/docs)"
  echo ""
  echo "    -isolevel=The transaction isolation level."
  echo "      (default=TRANSACTION_READ_COMMITTED)"
  echo ""
  echo "    -pagesize=The page size.(default=8192)"
  echo ""
  echo "    -cache=The cache size.(default=2063)"
  echo ""
  echo "    -sort=The sort size.(default=1024)"
  echo ""
  echo "EXAMPLE:"
  echo "${SCRIPT_NAME} -port=9092 -debug=3"
  echo "========================================================"
  exit
}


WL_HOME="C:/weblogic/src1036_16029jr/bea/wlserver_10.3"
. "${WL_HOME}/common/bin/commEnv.sh"

CLASSPATH="${POINTBASE_CLASSPATH}${CLASSPATHSEP}${WEBLOGIC_CLASSPATH}"

if [ "${DOMAIN_HOME}" != "" ] ; then
  CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${DOMAIN_HOME}"
fi

export CLASSPATH

SCRIPT_NAME=$0
PORT=9092
DEBUG=0
POINTBASE_INI="${WL_HOME}/common/eval/pointbase/tools/pointbase.ini"
DBHOME="${WL_HOME}/common/eval/pointbase/databases"
DOCS="${WL_HOME}/common/eval/pointbase/docs"
LICENSE="${WL_HOME}/common/eval/pointbase/lib/pbembedded.lic"
ISOLEVEL="TRANSACTION_READ_COMMITTED"
PAGESIZE=8192
CACHESIZE=2063
SORTSIZE=1024
WAIT="false"
CONSOLE=
SERVERWINDOW=
LOGFILE=
BACKGROUND="true"

while [ "$#" -gt "0" ]
do
  ARGNAME=`echo $1 | cut -d'=' -f1`
  ARGVALUE=`echo $1 | cut -d'=' -f2`
  
  if [ "`echo ${ARGVALUE} | cut -c1`" = "-" ] ; then
    echo "ERROR! Missing equal(=) sign. Arguments must be -name=value!"
    usage
  fi

  if [ "${ARGVALUE}" = "" ] ; then
    echo "ERROR! Missing value! Arguments must be -name=value!"
    usage
  fi
  
  case $ARGNAME in
     "-port") PORT=${ARGVALUE};;
     "-debug") DEBUG=${ARGVALUE};;
     "-ini") INI=${ARGVALUE};;
     "-home") DBHOME=${ARGVALUE};;
     "-doc") DOCS=${ARGVALUE};;
     "-isolevel") ISOLEVEL=${ARGVALUE};;
     "-pagesize") PAGESIZE=${ARGVALUE};;
     "-cache") CACHESIZE=${ARGVALUE};;
     "-sort") SORTSIZE=${ARGVALUE};;
     "-log") LOGFILE="/file:${ARGVALUE}";;
     "-wait") 
        if [ "${ARGVALUE}" = "true" ] || [ "${ARGVALUE}" = "false" ] ; then        
          WAIT=${ARGVALUE}
        else
          echo "UNKNOWN -wait OPTION $2! Valid options are \"true\" or \"false\"."
          usage
        fi;;
     "-background") 
        if [ "${ARGVALUE}" = "true" ] || [ "${ARGVALUE}" = "false" ] ; then        
          BACKGROUND=${ARGVALUE}
        else
          echo "UNKNOWN -background OPTION $2! Valid options are \"true\" or \"false\"."
          usage
        fi;;
     "-console") 
        if [ "${ARGVALUE}" = "false" ] ; then        
          CONSOLE="/noconsole"
        else 
          if [ "${ARGVALUE}" != "true" ] ; then
            echo "UNKNOWN -console OPTION $2! Valid options are \"true\" or \"false\"."
            usage
          fi
        fi;;
     "-win") 
        if [ "${ARGVALUE}" = "true" ] ; then        
          SERVERWINDOW="/win"
        else 
          if [ "${ARGVALUE}" != "false" ] ; then
            echo "UNKNOWN -win OPTION $2! Valid options are \"true\" or \"false\"."
            usage
          fi
        fi;;
     *) echo "UNKNOWN SWITCH $1!"
        usage;;
  esac
  shift
done

if [ "${INI}" = "" ] ; then
  echo "database.home=${DBHOME}" > ${POINTBASE_INI}
  echo "documentation.home=${DOCS}" >> ${POINTBASE_INI}
  echo "pbembedded.lic=${LICENSE}" >> ${POINTBASE_INI}
  echo "transaction.isolationlevel=${ISOLEVEL}" >> ${POINTBASE_INI}
  echo "database.pagesize=${PAGESIZE}" >> ${POINTBASE_INI}
  echo "cache.size=${CACHESIZE}" >> ${POINTBASE_INI}
  echo "sort.size=${SORTSIZE}" >> ${POINTBASE_INI}
else
  POINTBASE_INI=${INI}
fi

if [ "${WAIT}" != "false" ] ; then
  "${JAVA_HOME}/bin/java" com.pointbase.net.netServer ${CONSOLE} ${SERVERWINDOW} ${LOGFILE} /port:${PORT} /d:${DEBUG} /pointbase.ini="${POINTBASE_INI}"
else
  "${JAVA_HOME}/bin/java" com.pointbase.net.netServer /noconsole ${LOGFILE} /port:${PORT} /d:${DEBUG} /pointbase.ini="${POINTBASE_INI}" &
fi
