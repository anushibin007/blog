#!/bin/bash

source $MW_HOME/wlserver/server/bin/setWLSEnv.sh
$CMD_WLST << EOF
createDomain('$MW_HOME/wlserver/common/templates/domains/wls.jar', '$DOMAIN_HOME', 'weblogic', 'Passw0rd')
exit()
EOF