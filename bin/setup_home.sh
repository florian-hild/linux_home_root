#!/bin/bash

#-------------------------------------------------------------------------------
# Author     : Florian Hild
# Created    : 29-07-2022
# Description: Setup links in $HOME
#-------------------------------------------------------------------------------

export LANG=C
declare -r __SCRIPT_VERSION__='1.0'

if ! grep -wq '\. ~/linux_home_root/bash_profile' ~/.bash_profile; then
echo "Append to \"~/.bash_profile\":"
echo "-------------------------------------------------------------------------------"
tee -a $HOME/.bash_profile << END

if [[ -f ~/linux_home_root/bash_profile ]]; then
    . ~/linux_home_root/bash_profile
fi
END
echo "-------------------------------------------------------------------------------"
fi

links=(
  .gitconfig
  .vimrc
  .vim
)

for item in "${links[@]}"; do
  if [[ -L /root/${item} ]]; then
    ln -sf /root/linux_home_root/${item} /root/${item}
  else
    mv ${item} ${item}_$(date +%Y_%m_%d-%H_%M_%S)
    ln -s /root/linux_home_root/${item} /root/{item}
  fi
done

