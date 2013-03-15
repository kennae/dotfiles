#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

#PS1='[\u@\h \W]\$ '

alias pacman='sudo pacman-color'

alias shutdown='sudo shutdown -hP -t sec now'

complete -cf sudo
complete -cf man
complete -cf pacman

export TERMINAL="terminal &"
export EDITOR="nano"

##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=20
    # Indicate that there has been dir truncation
    local trunc_symbol="/..."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {

    #case $TERM in
    # xterm*|rxvt*)
    #     local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
    #      ;;
    # *)
    #     local TITLEBAR=""
    #      ;;
    #esac
    
    #PS1="$TITLEBAR ${EMK}[${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]${UC}\\$ ${NONE}"
    
    PS1="\[\e[1;33m\][\[\e[m\]\[\e[1;36m\]\u\[\e[m\]\[\e[1;33m\]] \${NEW_PWD} \[\e[m\]\[\e[1m\]\\$\[\e[m\] "
    
    # without colors: 
    #PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
