# Rust 
source "$HOME/.cargo/env"


#Aliases
alias ls="exa":
alias ll="exa -alghS"
alias brewARM="/opt/homebrew/bin/brew"
alias brew86="/usr/local/homebrew/bin/brew"
alias rdb="open \"rndebugger://set-debugger-loc?host=localhost&port=8081\""
alias nano="/opt/homebrew/Cellar/nano/5.9/bin/nano"
alias tmi="tmuxinator"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/matth/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/matth/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/matth/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/matth/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Path
PATH=$PATH:~/.npm_global/bin:/opt/homebrew/bin:/opt/homebrew/sbin:~/opt/miniconda3/bin:/Users/matth/.yarn/bin:~/Versd/Development/Versd-Toolbox:~/OpenSource/arrow-datafusion/target/release

# Environment Variables
export EDITOR='nvim'

# Import API keys, secrets, and such from .env
set -o allexport
source .env
set +o allexport

# Prompt Formatting
# Function to pull git branch
git_branch() {
    git symbolic-ref HEAD --short 2> /dev/null
}

# Set PS1 environment variable to define prompt format
export PS1="\u@\h \[\033[34m\]\W\[\033[33m\] \$(git_branch)\[\033[00m\]\n[\t] $ "

# Autojump setup
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
