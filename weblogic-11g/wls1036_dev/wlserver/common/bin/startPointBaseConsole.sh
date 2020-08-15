#!/bin/sh

usage(){
  echo "========================================================"
  echo " USAGE:"
  echo "  VALID SWITCHES:"
  echo "    -prompt=\"true\" or \"false\" If the PointBase Console"
  echo "              should prompt for the driver, url, and"
  echo "              login information or if it should use the"
  echo "              information provided by this script to"
  echo "              attempt the connection. (default=true)"
  echo ""
  echo "    NOTE: The options below do not apply if -prompt=true"
  echo ""
  echo "    -port=The PointBase Server's port.(default=9093)"
  echo ""
  echo "    -host=The PointBase Server's host name.(default=localhost)"
  echo ""
  echo "    -name=The PointBase Server's database name.(default=demo)"
  echo ""
  echo "    -user=The PointBase Server's user name.(default=weblogic)"
  echo ""
  echo "    -pass=The PointBase Server's password.(default=weblogic)"
  echo ""
  echo "EXAMPLE:"
  echo "${SCRIPT_NAME} -prompt=false -port=9093 -host=localhost -name=platform"
  echo "========================================================"
  exit
}

WL_HOME="C:/weblogic/src1036_16029jr/bea/wlserver_10.3"
. "${WL_HOME}/common/bin/commEnv.sh"

CLASSPATH="${POINTBASE_CLASSPATH}${CLASSPATHSEP}${POINTBASE_TOOLS}${CLASSPATHSEP}${CLASSPATH}"
export CLASSPATH

SCRIPT_NAME=$0
CONSOLEPROMPT="true"
HOST="localhost"
PORT=9093
DBNAME="demo"
USERNAME="weblogic"
PASSWORD="weblogic"

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
     "-host") HOST=${ARGVALUE};;
     "-port") PORT=${ARGVALUE};;
     "-user") USERNAME=${ARGVALUE};;
     "-pass") PASSWORD=${ARGVALUE};;
     "-name") DBNAME=${ARGVALUE};;
     "-prompt") 
        if [ "${ARGVALUE}" = "true" ] || [ "${ARGVALUE}" = "false" ] ; then        
          CONSOLEPROMPT=${ARGVALUE}
        else
          echo "UNKNOWN -prompt OPTION $2! Valid options are \"true\" or \"false\"."
          usage
        fi;;
     *) echo "UNKNOWN SWITCH $1!"
        usage;;
  esac
  shift
done

mypwd="`pwd`"

cd "${WL_HOME}/common/eval/pointbase/tools"

if [ "${CONSOLEPROMPT}" = "false" ] ; then
  "${JAVA_HOME}/bin/java" com.pointbase.tools.toolsConsole com.pointbase.jdbc.jdbcUniversalDriver jdbc:pointbase:server://${HOST}:${PORT}/${DBNAME} ${USERNAME}
else
  "${JAVA_HOME}/bin/java" com.pointbase.tools.toolsConsole 
fi

cd $mypwd
