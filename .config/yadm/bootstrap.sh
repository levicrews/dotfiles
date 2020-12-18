#! /usr/bin/env sh

# References: https://github.com/rkalis/dotfiles and associated blog posts

DIR=$(dirname "$0")
cd "$DIR"

source coloredecho.sh

info "Prompting for sudo password..."
if sudo -v; then
    # Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
    success "Sudo credentials updated."
else
    error "Failed to obtain sudo credentials."
fi

COMMENT=\#*

sudo -v
add-apt-repository ppa:inkscape.dev/stable
apt-get update

find * -name "*.list" | while read fn; do
    cmd="${fn%.*}" # Bash string operator
    set -- $cmd
    info "Installing $1 packages..."
    while read package; do
        if [[ $package == $COMMENT ]]; then continue; fi
        if [[ $cmd == code ]]; then
            substep_info "Installing VSCode extension $package..."
            $cmd --install-extension $package
        else
            substep_info "Installing $package..."
            $cmd install $package
        fi
    done < "$fn"
    success "Finished installing $1 packages."
done

chmod 700 ../rofi/scripts/rofi-org-todo.py
chmod 700 ../rofi/scripts/rofi-org-inspect.py