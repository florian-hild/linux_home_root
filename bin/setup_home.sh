#!/bin/bash

if ! grep -wq '\. ~/linux_home_root/\.bash_profile' ~/.bash_profile; then
cat <<EOT >> $HOME/.bash_profile

if [ -f $HOME/linux_home_root/.bash_profile ]; then
    . $HOME/linux_home_root/.bash_profile
fi
EOT
fi

ln -sfn $HOME/linux_home_root/.vim $HOME/.vim
ln -sfn $HOME/linux_home_root/.vimrc $HOME/.vimrc
ln -sfn $HOME/linux_home_root/.gitconfig $HOME/.gitconfig
ln -sfn $HOME/linux_home_root/.digrc $HOME/.digrc

