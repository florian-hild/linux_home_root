#!/bin/bash

#-------------------------------------------------------------------------------
# Author     : Florian Hild
# Created    : 29-07-2022
# Description: Setup links in $HOME
#-------------------------------------------------------------------------------

export LANG=C
declare -r __SCRIPT_VERSION__='1.0'

echo "Append to \"~/.bash_profile\":"
echo "-------------------------------------------------------------------------------"
tee -a $HOME/.bash_profile << END

if [[ -f ~/linux_home_root/bash_profile ]]; then
    . ~/linux_home_root/bash_profile
fi
END
echo "-------------------------------------------------------------------------------"
