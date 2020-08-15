#!/bin/sh

usage(){
  echo "========================================================"
  echo " USAGE:"
  echo "  VALID SWITCHES:"
  echo "    -port=The PointBase Server's port.(default=9093)"
  echo ""
  echo "    -host=The PointBase Server's host name.(default=localhost)"
  echo ""
  echo "    -name=The PointBase Server's database name.(default=demo)"
  echo ""
  echo "    -user=The PointBase Server's user name.(default=PBSYSADMIN)"
  echo ""
  echo "    -pass=The PointBase Server's password.(default=PBSYSADMIN)"
  echo ""
  echo "EXAMPLE:"
  echo "${SCRIPT_NAME} -port=9093 -host=localhost -name=platform"
  echo "========================================================"
  exit
}

WL_HOME="C:/weblogic/src1036_16029jr/bea/wlserver_10.3"
. "${WL_HOME}/common/bin/commEnv.sh"

CLASSPATH="${POINTBASE_CLASSPATH}${CLASSPATHSEP}${POINTBASE_TOOLS}${CLASSPATHSEP}${CLASSPATH}"
export CLASSPATH

SCRIPT_NAME=$0
HOST="localhost"
PORT=9093
DBNAME="demo"
USERNAME="PBSYSADMIN"
PASSWORD="PBSYSADMIN"

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
     *) echo "UNKNOWN SWITCH $1!"
        usage;;
  esac
  shift
done

echo "SHUTDOWN FORCE;" | "${JAVA_HOME}/bin/java" com.pointbase.tools.toolsCommander com.pointbase.jdbc.jdbcUniversalDriver jdbc:pointbase:server://${HOST}:${PORT}/${DBNAME} ${USERNAME} ${PASSWORD}
