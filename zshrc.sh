# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# -- Prompt

# Modify the prompt to contain git branch name if applicable
git_prompt_info() {
    current_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    if [[ -n $current_branch ]]; then
        echo "%{$fg_bold[blue]%}($current_branch)%{$reset_color%}"
    fi
}

setopt promptsubst

PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[cyan]%}%c%{$reset_color%}$(git_prompt_info) %{$fg_bold[cyan]%}›%{$reset_color%} '

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
