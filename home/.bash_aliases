# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias t='tree | less'

alias vim='vim -p'
alias vi='vim'
alias ack='ack-grep'
alias s='git status'
alias d='git diff'
alias ds='git diff --staged'
alias b='git branch'
alias chrome='google-chrome'

alias aardwolf="tt++ -e '#ses a aardwolf.org 23;Lyenn'"

alias be="bundle exec"
alias bu="bundle update"
alias bi="bundle install"
alias clip="xclip -selection clipboard"

alias ..="cd .."

alias git='hub'
alias rmdbc="find . -name '* (*conflicted*' -exec rm {} \;"

alias em="/usr/bin/emacsclient -ct"
alias es="/usr/bin/emacs --daemon"

alias gsch2pcb="gsch2pcb --use-files -d ~/electronics/gEDA/components -d `pwd`"

alias emacs="emacs -nw"
