#!/usr/bin/env bash

platform='unknown'
username=$(whoami)

rlinux='^linux.*'
rosx='^darwin.*'
rcygwin='^cygwin.*'
rmsys='^msys.*'
rwin32='^win32.*'
rfreebsd='^freebsd.*'

#if [[ $OSTYPE == "linux-gnu" ]]; then
if [[ $OSTYPE =~ $rlinux ]]; then
        platform='linux'
#elif [[ $OSTYPE == "darwin"* ]]; then
elif [[ $OSTYPE =~ $rosx ]]; then
        platform='osx'
#elif [[ $OSTYPE == "cygwin" ]]; then
elif [[ $OSTYPE =~ $rcygwin ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
	platform = 'cygwin'
#elif [[ $OSTYPE == "msys" ]]; then
elif [[ $OSTYPE =~ $rmsys ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
	platform = 'msys'
#elif [[ $OSTYPE == "win32" ]]; then
elif [[ $OSTYPE =~ $rwin32 ]]; then
        # I'm not sure this can happen.
        platform = 'win'
#elif [[ $OSTYPE == "freebsd"* ]]; then
elif [[ $OSTYPE =~ $rfreebsd ]]; then
        platform = 'freebsd'
fi

#echo "Running on OS = "$OSTYPE" as user = "$username" and found platform to be = "$platform

#   -------------------------------
#   1. ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Change Prompt
#   ------------------------------------------------------------

PS1="[\e[38;5;43m\]\u@\h\[\e[00m\]:\[\e[38;5;43m\]\w\[\e[00m\]\$ "
# For any user made them standout as yellow. If they are root or sona, below PS1 will set appropriate colour


if [[ "$username" == "root" ]]; then
        if [[ "$platform" == "linux" ]]; then
                # Red prompt, red colour dir
                PS1="\e[38;5;1m\]\t @\h\[\e[00m\]:\[\e[38;5;1m\]\w\[\e[00m\]\$ "
        elif [[ "$platform" == "osx" ]]; then
                # White on red prompt, red colour dir
                #PS1="\e[48;5;1m\]\u@\h\[\e[00m\]:\[\e[31m\]\w\[\e[00m\]\$ "
                PS1="\e[48;5;1m\] \t \[\e[00m\]:\[\e[31m\]\w\[\e[00m\]\$ "
        fi
fi

if [[ "$username" == "sona" ]]; then
        if [[ "$platform" == "linux" ]]; then
                # green prompt, green colour dir
                PS1="\e[38;5;82m\]\t @\h\[\e[00m\]:\[\e[38;5;82m\]\w\[\e[00m\]\$ "
        elif [[ "$platform" == "osx" ]]; then
                # orange prompt, yellow colour dir
                #PS1='\e[38;5;208m\]\u@\h\[\e[00m\]:\[\e[38;5;226m\]\w\[\e[00m\]\$ '
                #PS1="\e[38;5;208m\]\u\[\e[00m\]@\e[38;5;208m\]\h\[\e[00m\]:\[\e[38;5;226m\]\w\[\e[38;5;82m\]\$(parse_git_branch)\e[38;5;208m\]\$(parse_git_dirty)\[\e[00m\]\$ "
                PS1="\[\e[0;32m\] \[\e[1;32m\]\t \[\e[38;5;208m\]\w\[\e[38;5;82m\]\$(parse_git_branch)\e[38;5;208m\]\$(parse_git_dirty)\[\e[00m\]\$ "

        fi
fi

# Green prompt, green colour dir (34m is green on CentOS !!)
# PS1='[\e[38;5;82m\]\u@\h\[\e[00m\]:\[\e[38;5;82m\]\w\[\e[00m\]\$ '
# Blue prompt, blue colour dir (32m is blue on CentOS !!)
# PS1='[\e[38;5;32m\]\u@\h\[\e[00m\]:\[\e[38;5;32m\]\w\[\e[00m\]\$ '
# Yellow prompt, yellow colour dir
# PS1='[\e[38;5;226m\]\u@\h\[\e[00m\]:\[\e[38;5;226m\]\w\[\e[00m\]\$ '
# Red prompt, red colour dir
# PS1='[\e[38;5;1m\]\u@\h\[\e[00m\]:\[\e[38;5;1m\]\w\[\e[00m\]\$ '
# Orange prompt, orange colour dir
# PS1='[\e[38;5;208m\]\u@\h\[\e[00m\]:\[\e[38;5;208m\]\w\[\e[00m\]\$ '
# Orange prompt, yellow colour dir
# PS1='[\e[38;5;208m\]\u@\h\[\e[00m\]:\[\e[38;5;226m\]\w\[\e[00m\]\$ '

# White on red prompt, red colour dir
# PS1='[\e[48;5;1m\]\u@\h\[\e[00m\]:\[\e[31m\]\w\[\e[00m\]\$ '

#   Set Paths
#   ------------------------------------------------------------

# Add Visual Studio Code (code)
# export PATH="${PATH}:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/nano


#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

#alias to refer to non aliased commands
bcd() { builtin cd "$@"; }
bgrep() { bultin grep "$@"; }
bcat() { bultin cat "$@"; }
bcp() { bultin cp "$@"; }
bmv() { bultin mv "$@"; }
bmkdir() { bultin mkdir "$@"; }
bdf() { bultin df "$@"; }
bdu() { bultin du "$@"; }
bpbcopy() { bultin pbcopy "$@"; }
bpbpaste() { bultin pbpaste "$@"; }

alias cp='cp -iv'                                       # Preferred 'cp' implementation
alias mv='mv -iv'                                       # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                                 # Preferred 'mkdir' implementation
if [[ "$platform" == "linux" ]]; then
        alias ll='ls -Flhp --group-directories-first --color=auto'       # Preferred 'll' implementation
        alias lla='ls -FlhpA --group-directories-first --color=auto'     # Preferred 'lla' implementation
        alias df='df -h -x tmpfs -x devtmpfs'
        alias du='du -h's
elif [[ "$platform" == "osx" ]]; then
        alias ll='ls -FGlhp'                            # Preferred 'll' implementation
        alias lla='ls -FGlhpA'                          # Preferred 'lla' implementation
        alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"       #list only directories
        alias df='df -H'
        alias du='du -H'
fi


#alias less='less -FSRXc'                               # Preferred 'less' implementation
cd() { builtin cd "$@"; ll; }                           # Always list directory contents upon 'cd'
alias cd.='cd ~'                                        #Go to home directory
alias cd..='cd ../'                                     # Go back 1 directory level (for fast typers)
alias ..='cd ../'                                       # Go back 1 directory level
alias ...='cd ../../'                                   # Go back 2 directory levels
alias .2='cd ../../'                                    # Go back 2 directory levels
alias .3='cd ../../../'                                 # Go back 3 directory levels
alias .4='cd ../../../../'                              # Go back 4 directory levels
alias .5='cd ../../../../../'                           # Go back 5 directory levels
alias .6='cd ../../../../../../'                        # Go back 6 directory levels

if [[ "$platform" == "osx" ]]; then
        alias cdc='cd ~/z.code'
        alias cda='cd ~/z.ansible'
        alias cdar='cd ~/.ansible/roles'
        alias cdn='cd ~/z.dotnet'
        alias cdp='cd ~/z.python'
        alias cdv='cd ~/r.devops'
        alias cdf='cd ~/r.dotfiles'
        alias cdr='cd ~/zrmac'
        alias cdd='cd ~/zdisk'
        alias cdl='cd ~/zlinux'
        alias cdm='cd ~/zgrm'
        alias cdo='cd ~/zgro'
        alias cd0='cd "/od/OneDrive - sgl/"'
        alias cd0h='cd "/od/OneDrive - sgl/zhs"'
        alias cd0m='cd "/od/OneDrive - sgl/zgrm"'
        alias cd0o='cd "/od/OneDrive - sgl/zgro"'
        alias cd0a='cd "/od/OneDrive - sgl/zaro"'

        alias gs='git status'
        alias ga='git add -u;git add *'
        alias gp='git push'
        #TODO: alias gitmm='$old=$(parse_git_branch); git push; git checkout master; git merge $old; git checkout $old'
        alias gc='git commit -m'

        alias ansible-lint='ansible-lint --force-color'
        alias al='ansible-lint'
fi

alias grep='grep --colour=always'
alias pbcopy='xclip -selection clipboard'               # To simluate pbcopy from mac
alias pbpaste='xclip -selection clipboard -o'           # To siumulate pbpaste from mac
#alias pbcopy='xsel --clipboard --input'
#alias pbpaste='xsel --clipboard --output'

alias cat='cat -n'                                      # To display line numbers

mkd () { mkdir -p "$1" && cd "$1"; }                    # mkd:          Makes new Dir and jumps inside

if [[ "$platform" == "osx" ]]; then
        trash () { command mv "$@" ~/.Trash ; }         # trash:        Moves a file to the MacOS trash
fi

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.            Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   -------------------------------
#   3. FILE AND FOLDER MANAGEMENT
#   -------------------------------


#   ---------------------------
#   4. SEARCHING
#   ---------------------------

alias findc="find . -name "                             # findc:    Quickly search for file in current dir
alias findr="find / -name "                             # findr:    Quickly search for file in whole of filesystem

ff () { /usr/bin/find . -name "$@" ; }                  # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }              # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }              # ffe:      Find file whose name ends with a given string



#   ---------------------------
#   5. Python virtualenvwrapper initialisation
#   ---------------------------

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/zPython/

#below line is for setting a custom path for python (e.g. python3 installed using homebrew)
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
if [[ "$platform" == "linux" ]]; then
        export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
        if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
                source /usr/bin/virtualenvwrapper.sh
        fi
elif [[ "$platform" == "osx" ]]; then
        export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
        if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
                source /usr/local/bin/virtualenvwrapper.sh
        fi
fi


#   ---------------------------
#   6. Git functions for cmd line
#   ---------------------------


# Activate colors and dirty state
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWDIRTYSTATE=true

# Find dirty state
parse_git_dirty() {
  [[ -n "$(git status -s 2> /dev/null)" ]] && echo "*"
}

# Get branch name
parse_git_branch() {
#  git branch 2> /dev/null | sed -e '/^[^*]/d' -d 's/* \(.*\)/ (\1)/'
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

exit