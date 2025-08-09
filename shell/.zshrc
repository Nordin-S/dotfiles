#zmodload zsh/zprof
USE_POWERLINE="false"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob

# The following lines were added by compinstall
zstyle :compinstall filename '/home/nauot/.zshrc'
autoload -Uz compinit
compinit -C

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# -----------------------------------------------------
# Key bindings
# -----------------------------------------------------
bindkey -e
bindkey -s '\ec' '~/nauot-scripts/tmux-cht.sh'
bindkey -s '\es' '~/nauot-scripts/tmux-sessionizer.sh'
bindkey -s '\ew' '~/nauot-scripts/tmux-windowizer.sh'
#bindkey -s '\ef' '~/nauot-scripts/fix-btusb.sh'

function clear_pane() {
    clear
    if [[ $PWD == $HOME ]]; then
        echo -n "➜ ~ "
    else
        echo -n "➜" $(basename "$PWD") " "
    fi
}
zle -N clear_pane
bindkey '^[^U' clear_pane

# -----------------------------------------------------
# Exports 
# -----------------------------------------------------
# export PATH="$PATH:$HOME/.local/bin:$HOME/nauot-scripts"
# export QT_QPA_PLATFORMTHEME=qt5ct
# Created by `pipx` on 2023-11-21 19:16:59
# export PATH="$PATH:/home/nauot/.local/bin"
export PATH="/home/nauot/.local/bin:/opt/nvim-linux64/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/nauot/nauot-scripts:$PATH"

# -----------------------------------------------------
# plugin manager 
# -----------------------------------------------------
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
#plug "ajeetdsouza/zoxide"
#plug "z-shell/F-Sy-H"
plug "esc/conda-zsh-completion"
# plug "wintermi/zsh-starship"
# plug "starship/starship"


# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias c='clear'
alias nf='neofetch'
#alias pf='pfetch'
alias ls='exa -al'
alias shutdown='systemctl poweroff'
alias v='nvim'
alias ts='~/nauot-scripts/snapshot.sh'
#alias matrix='cmatrix'
# alias od='~/private/onedrive.sh'
# alias rw='~/.config/waybar/reload.sh'
alias winclass="xprop | grep 'CLASS'"
alias dot="cd ~/repo/dotfiles"

# -----------------------------------------------------
# Window Managers
# -----------------------------------------------------

# alias wb='hyprland'

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gcheck="git checkout"

# -----------------------------------------------------
# SCRIPTS
# -----------------------------------------------------

# alias w='~/nauot-scripts/updatewal-swww.sh'
# alias gr='python ~/dotfiles/scripts/growthrate.py'
# alias ChatGPT='python ~/mychatgpt/mychatgpt.py'
# alias chat='python ~/mychatgpt/mychatgpt.py'
# alias ascii='~/dotfiles/scripts/figlet.sh'

# -----------------------------------------------------
# VIRTUAL MACHINE
# -----------------------------------------------------

# alias vm='~/private/launchvm.sh'
# alias lg='~/dotfiles/scripts/looking-glass.sh'
# alias vmstart='virsh --connect qemu:///system start win11'
# alias vmstop='virsh --connect qemu:///system destroy win11'

# -----------------------------------------------------
# EDIT CONFIG FILES
# -----------------------------------------------------

#alias confp='nvim ~/.config/picom/picom.conf'
#alias confb='nvim ~/.bashrc'
alias confz='nvim ~/.zshrc'
#alias confh='nvim ~/.config/hypr/hyprland.conf'
alias conft='nvim ~/.config/tmux/tmux.conf'

# -----------------------------------------------------
# EDIT NOTES
# -----------------------------------------------------

# alias notes='vim ~/notes.txt'

# -----------------------------------------------------
# SYSTEM
# -----------------------------------------------------

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'


# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
# cat ~/.cache/wal/sequences
#(cat ~/.cache/wal/sequences &)
#source ~/.cache/wal/colors-tty.sh
#


# start zsh with tmux if it exists
 if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
     tmux attach -t default || tmux new -s default
 fi


# =============================================================================               
#                                                                                             
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):                    
#                                                                                             
eval "$(zoxide init zsh)"      

# pipx autocomplition
#eval "$(register-python-argcomplete pipx)"

#eval "$(starship init zsh)" # keep at the end of all lines

export GEMINI_API_KEY="AIzaSyALiFaF-jq2tVgtYhhdRfi4qN0MKPDuQpE"
# export Gemini_API_KEY="AIzaSyCm0xUFksT9Lh6DxGlEdjDCe_fkzg5resg"
# export GEMINI_API_KEY="AIzaSyD_joou9qaZ2xdT6MASKhCOzbVS-sO7NdQ" # IVAN

export GEMINI_SYSTEM_MD=true



export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
