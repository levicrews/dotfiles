# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias l.='ls -d .* --color=auto' #shows hidden files
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# cd aliases
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

# making directories
alias mkdir='mkdir -pv'

function mkcd ()
{
  mkdir -p -- "$1" && cd -P -- "$1"
}

# safety: ask before overwriting
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

# yadm
alias yl='yadm list -a'
alias ys='yadm status'
alias ydiff='yadm diff'
alias ya='yadm add'
alias yc='yadm commit'
alias yph='yadm push'
alias ypl='yadm pull'

# fdfind
alias fd='fdfind'