# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# editors
export ALTERNATE_EDITOR="code"
export EDITOR="emacsclient -c -a code"         # $EDITOR opens in GUI mode
export VISUAL="emacsclient -c -a code"         # $VISUAL opens in GUI mode

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#################################### PROMPT ####################################

# Use starship prompt: https://starship.rs/guide/
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

################################### ALIASES ####################################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

################################# COMPLETION ###################################

# enable programmable completion features (you don't need to enable this
# if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

####################### SOURCE USER SCRIPTS & FUNCTIONS ########################

. /usr/share/autojump/autojump.sh

# Search for text within PDFs in directory
# usage: pdfsearch "charpattern" ~/Dropbox/crewsbib/pdf)
pdfsearch() {
    # usage: pdfsearch PATTERN [PATH...]
    command -v pdfgrep >/dev/null 2>&1 || { echo "pdfgrep not installed"; return 127; }
    [ -n "${1-}" ] || { echo "usage: pdfsearch PATTERN [PATH...]"; return 2; }
    local pat="$1"; shift
    [ "$#" -gt 0 ] || set -- .
    pdfgrep -R -nH -m1 --color=auto -- "$pat" "$@"
}

# Fuzzy jump to a git repo under ~/Documents
gitgo() {
    local base="${REPO_BASE:-$HOME/Documents}"
    local q="$*" sel

    # Build the list each time: any dir containing a ".git" (depth 1–2).
    # Works whether your repos are ~/Documents/<repo> or ~/Documents/.../<repo>.
    mapfile -t _repos < <(find "$base" -mindepth 1 -maxdepth 2 -type d -name .git -printf '%h\n' 2>/dev/null)

    # Pick with fzf (pre-filter with your query). Auto-enter if exactly one match.
    sel="$(printf '%s\n' "${_repos[@]}" \
        | fzf --query="$q" --select-1 --exit-0 --height=40% --reverse \
              --prompt='repo> ' \
              --preview='
                  printf "%s\n\n" {}
                  git -C {} rev-parse --abbrev-ref HEAD 2>/dev/null
                  git -C {} --no-pager -c color.status=always status -sb 2>/dev/null | sed -n "1,20p"
              ' --preview-window=right,60%)"

    # Go to repo (or fall back to base if nothing selected).
    if [[ -n "$sel" ]]; then
        cd "$sel" || return
    else
        cd "$base" || return
    fi
}

# Run a command across all git repos under $HOME/Documents (or $REPO_BASE).
# usage: gitbulk git pull --ff-only (default: git status)
gitbulk() {
    local base="${REPO_BASE:-$HOME/Documents}"
    local -a repos cmd
    local rc=0

    # collect repos (handles spaces/newlines)
    readarray -d '' repos < <(find "$base" -mindepth 1 -maxdepth 2 \
        -type d -name .git -printf '%h\0' 2>/dev/null)

    (( ${#repos[@]} )) || { echo "gitbulk: no git repos under $base"; return 1; }

    # default to `git status`
    if (( $# == 0 )); then
        cmd=(git status)
    else
        cmd=("$@")
    fi

    for d in "${repos[@]}"; do
        printf '==> %s\n' "$(basename "$d")"
        ( cd "$d" && "${cmd[@]}" ) || rc=1
        echo
    done
    return $rc
}
