if [ -f ~/.oh-my-zsh/custom/plugins/auto-fu/auto-fu.zsh/auto-fu.zsh ]; then
    source ~/.oh-my-zsh/custom/plugins/auto-fu/auto-fu.zsh/auto-fu.zsh; 
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
fi
