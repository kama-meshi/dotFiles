# Exports
export ANDROID_SDK=~/Documents/30.APP_FILES/AndroidSDK
export ANDROID_NDK=~/Documents/30.APP_FILES/AndroidNDK
export PATH="$PATH:$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools"
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
export SVN_EDITOR="vi"
export GOPATH=~/.go

# Variable
HISTSIZE=100000
SAVEHIST=100000

# Set Options
setopt correct
setopt list_packed 
setopt hist_ignore_dups
setopt share_history 
setopt EXTENDED_HISTORY

# KEY BIND
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "^[^H" run-help
bindkey "[^H" backward-kill-word


# Alias
alias svn=colorsvn
alias r=rmtrash
alias brew_cask_alfred_link="brew cask alfred link"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias pbcopytr="tr -d '\n' | pbcopy"
alias lt="l -tT"
alias diff="colordiff"
alias s3="aws s3"
alias adb_restart_server="adb kill-server;adb start-server"
alias f="open ."
alias ctags="/usr/local/bin/ctags"
alias sed="gsed"
alias emacs="emacsclient -nw"

# Functions
pass2clip(){
  G_PASS=$(pwgen 12 1 -Bync)
  echo -n $G_PASS | pbcopy
  echo "generated: $G_PASS"
  return
}
dash(){
  open "dash://$@"
}
have(){
  if [ -e "`which $@`" ];then
    return 0
  else
    return 1
  fi
}
redmine_my_issues(){
  curl http://redmine.rcsc.co.jp/issues.json\?key\=18ca6c256aa6d0cddca507cfe70ea92c8e1da4db | jq ".issues[] | select(.assigned_to.name == \"Yuki Ogimoto\") | { desc:.description, subject:.subject}"
  return
}
dic(){
  open dict:///$1
}
cdf(){
  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]
  then
          cd "$target"
          pwd
  else
          echo 'No Finder window found' >&2
  fi
}
strlen(){
  local tmp
  tmp="$@"
  echo "${#tmp}"
  unset local
}
start_emacs_daemon(){
  # Emacs Daemon
  /usr/local/bin/emacs --daemon
}
# http://d.hatena.ne.jp/hiboma/20120315/1331821642
pbcopy-buffer(){
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}

zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer

# Valiable
POCKET=~/Documents/00.POCKET
readonly POCKET
TODO=~/Documents/10.TODO
readonly TODO
DOING=~/Documents/11.DOING
readonly DOING
DONE=~/Documents/12.DONE
readonly DONE
RCS_SVN=~/Documents/20.RCS_SVN
readonly RCS_SVN
APP_FILES=~/Documents/30.APP_FILES
readonly APP_FILES
WORK=~/Documents/99.WORK
readonly WORK
MSG_POOL=~/Documents/99.MSG_POOL
readonly MSG_POOL
fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

# Compdef
compdef colorsvn=svn

# Setting
chpwd(){ ls }
. `brew --prefix`/etc/profile.d/z.sh
source /usr/local/share/zsh/site-functions/*

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both
 
# zaw-src-cdr
# zstyle ':filter-select' case-insensitive yes # 絞り込みをcase-insensitiveに
# bindkey '^@' zaw-cdr 
# zaw-src-history
# bindkey '^r' zaw-history 

