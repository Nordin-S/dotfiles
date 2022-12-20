# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$PATH:/mnt/c/Windows/System32"
# start zsh with tmux if it exists
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=()
source ~/.oh-my-zsh/oh-my-zsh.sh

[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
# Example install plugins
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "ajeetdsouza/zoxide"
plug "z-shell/F-Sy-H"

# Example theme - fix this if powerlevel10k support zap
# plug "zap-zsh/zap-prompt"

# Example install completion
plug "esc/conda-zsh-completion"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# open nvim when vim is called
alias vim="nvim"
export EDITOR="nvim"

# add to path
# export PATH=$PATH:$HOME/scripts
path+=($HOME/scripts)

# Where should I put you?
bindkey -s '\ef' 'tmux-sessionizer.sh^M'
