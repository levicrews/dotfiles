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

# cat with syntax highlighting and Git integration
alias cat='bat'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# cd aliases
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'

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

# disk usage
alias du='du -d 1 -h | sort -h'

# fuzzy finder file preview
alias pf="fzf --preview='bat --color=always --style=numbers {}' --bind shift-up:preview-up,shift-down:preview-down"
alias pt="fzf --preview='less {}' --bind shift-up:preview-up,shift-down:preview-down"

# radian: A 21st-century R console
# note: "R" still opens the traditional R console
alias r="radian"

# fuzzy matching most-visited directories
# https://blog.chaselambda.com/2014/11/07/hella-fast-command-line-navigation.html
alias zc="new_loc=\$(cat ~/.local/share/autojump/autojump.txt | sort -n | grep -Po '^[^\s]+\s+(\K.*)' | fzf +s -e) && cd \"\$new_loc\""