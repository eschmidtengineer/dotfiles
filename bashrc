# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
          . /etc/bashrc
fi

# git completion
source ~/dotfiles/git-completion.bash

# git branch 
function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u@\h \[\033[1;33m\]\w\[\033[0m\]$(parse_git_branch)$ '''

#history
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "

#user specific aliases and functions
alias ls='ls -F --color=auto'
alias la='ls -lah --color'
alias sc='screen -D -RR'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

#git aliases
alias gs="git status"
alias gc="git commit"
alias gr="git checkout"
alias ga="git add"
alias gl="git lola"

# php style fixer
alias phpfix="php /usr/local/bin/php-cs-fixer fix"


# dev-link and composer stuff
alias devlink="sudo dev-link;
                cd /var/web/core;
                sudo composer update && sudo composer dump-autoload -o;
                cd -"

# start report worker               
alias report_worker="/home/eschmidt/repos/gearman_workers/opt/css/gearman_workers/report/worker"

# start process runner orchestrator
alias process_runner_orchestrator="/usr/bin/php /home/eschmidt/repos/gearman_workers/opt/css/gearman_workers/process_runner_orchestrator/worker"

# start process runner worker
alias process_runner_workers="echo {1..20} | xargs -n1 echo | xargs -I'{}' -P10 /usr/bin/php /home/eschmidt/repos/gearman_workers/opt/css/gearman_workers/process_runner/worker"

# view apache logs
alias apachelog="clear;
                sudo tail -20 /var/log/httpd/error_ssl.log"
