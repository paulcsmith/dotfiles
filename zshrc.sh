# -- Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PS1='%B%F{cyan}%1~%f%b '
# PS1=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{green}%r (%b)%f '
zstyle ':vcs_info:*' enable git

## This may need to change in codespaces...
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Setup autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Hit jj to enter vi mode in the command prompt
bindkey jj vi-cmd-mode

# Init rbenv and nodeenv if not in codespaces
if [ -n $CODESPACES]
then
    eval "$(nodenv init -)"
    eval "$(rbenv init -)"
fi

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Fixes for macOS. Needs to only run when macos is the current env
if [ $(uname -s) = "Darwin" ]
then
    # Fix for Crystal
    export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
    export PATH="/usr/local/opt/openssl/bin:$PATH"
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
fi
