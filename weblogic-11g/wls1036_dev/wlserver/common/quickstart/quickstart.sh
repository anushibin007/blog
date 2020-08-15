#!/bin/sh

"$MW_HOME/utils/quickstart/quickstart.sh" install.dir="$MW_HOME/wlserver" product.alias.id="@PROD_ALIAS_ID" product.alias.version="@PROD_ALIAS_VERSION" $*

exit $?  
