# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes manually installed binaries
export PATH=/usr/local/texlive/2020/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2020/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2020/texmf-dist/doc/info:$INFOPATH
export PATH=/usr/local/stata16:$PATH
export PATH=/usr/local/stata18:$PATH
export PATH=~/.emacs.d/bin:$PATH
export PATH=/opt/gurobi/bin:$PATH
export PATH=~/.config/rofi/bin:$PATH

# set Gurobi license
export GRB_LICENSE_FILE=/opt/gurobi/gurobi.lic
. "$HOME/.cargo/env"
