USE_POWERLINE="false"
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob

# The following lines were added by compinstall
zstyle :compinstall filename '/home/narch/.zshrc'
autoload -Uz compinit
compinit

# -----------------------------------------------------
# Key bindings
# -----------------------------------------------------
bindkey -e
bindkey -s '\ec' '~/narch-scripts/tmux-cht.sh'
bindkey -s '\es' '~/narch-scripts/tmux-sessionizer.sh'
bindkey -s '\ew' '~/narch-scripts/tmux-windowizer.sh'
bindkey -s '\ef' '~/narch-scripts/fix-btusb.sh'

# -----------------------------------------------------
# Exports 
# -----------------------------------------------------
export PATH="$PATH:$HOME/.local/bin:$HOME/narch-scripts"
export QT_QPA_PLATFORMTHEME=qt5ct


# -----------------------------------------------------
# plugin manager 
# -----------------------------------------------------
# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
# plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "ajeetdsouza/zoxide"
plug "z-shell/F-Sy-H"
plug "esc/conda-zsh-completion"
# plug "wintermi/zsh-starship"
# plug "starship/starship"

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias c='clear'
alias nf='neofetch'
alias pf='pfetch'
alias ls='exa -al'
alias shutdown='systemctl poweroff'
alias v='nvim'
alias ts='~/narch-scripts/snapshot.sh'
alias matrix='cmatrix'
# alias od='~/private/onedrive.sh'
# alias rw='~/.config/waybar/reload.sh'
alias winclass="xprop | grep 'CLASS'"
alias dot="cd ~/.dotfiles"

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

alias w='~/narch-scripts/updatewal-swww.sh'
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

alias confp='nvim ~/.config/picom/picom.conf'
alias confb='nvim ~/.bashrc'
alias confz='nvim ~/.zshrc'
alias confh='nvim ~/.config/hypr/hyprland.conf'
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
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh
#

# -----------------------------------------------------
# PFETCH
# -----------------------------------------------------
echo ""
pfetch

# start zsh with tmux if it exists
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi



# =============================================================================                                                                                                               
#                                                                                                                                                                                             
# Utility functions for zoxide.                                                                                                                                                               
#                                                                                                                                                                                             
                                                                                                                                                                                              
# pwd based on the value of _ZO_RESOLVE_SYMLINKS.                                                                                                                                             
function __zoxide_pwd() {                                                                                                                                                                     
    \builtin pwd -L                                                                                                                                                                           
}                                                                                                                                                                                             
                                                                                                                                                                                              
# cd + custom logic based on the value of _ZO_ECHO.                                                                                                                                           
function __zoxide_cd() {                                                                                                                                                                      
    # shellcheck disable=SC2164                                                                                                                                                               
    \builtin cd -- "$@"                                                                                                                                                                       
}                                                                                                                                                                                             
                                                                                                                                                                                              
# =============================================================================                                                                                                               
#                                                                                                                                                                                             
# Hook configuration for zoxide.                                                                                                                                                              
#                                                                                                                                                                                             
                                                                                                                                                                                              
# Hook to add new entries to the database.                                                                                                                                                    
function __zoxide_hook() {                                                                                                                                                                    
    # shellcheck disable=SC2312                                                                                                                                                               
    \command zoxide add -- "$(__zoxide_pwd)"                                                                                                                                                  
}                                                                                                                                                                                             
                                                                                                                                                                                              
# Initialize hook.                                                                                                                                                                            
# shellcheck disable=SC2154                                                                                                                                                                   
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then                                                                          
    chpwd_functions+=(__zoxide_hook)                                                                                                                                                          
fi                                                                                                                                                                                            
                                                                                                                                                                                              
# =============================================================================                                                                                                               
#                                                                                                                                                                                             
# When using zoxide with --no-cmd, alias these internal functions as desired.                                                                                                                 
#                                                                                                                                                                                             
                                                                                                                                                                                              
__zoxide_z_prefix='z#'                                                                                                                                                                        
                                       

# Jump to a directory using only keywords.                                                                                                                                                      
function __zoxide_z() {                                                                                                                                                                         
    # shellcheck disable=SC2199                                                                                                                                                                 
    if [[ "$#" -eq 0 ]]; then                                                                                                                                                                   
        __zoxide_cd ~                                                                                                                                                                           
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then                                                                                          
        __zoxide_cd "$1"                                                                                                                                                                        
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"?* ]]; then                                                                                                                                       
        # shellcheck disable=SC2124                                                                                                                                                             
        \builtin local result="${@[-1]}"                                                                                                                                                        
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"                                                                                                                                           
    else                                                                                                                                                                                        
        \builtin local result                                                                                                                                                                   
        # shellcheck disable=SC2312                                                                                                                                                             
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&                                                                                                                
            __zoxide_cd "${result}"                                                                                                                                                             
    fi                                                                                                                                                                                          
}                                                                                                                                                                                               
                                                                                                                                                                                                
# Jump to a directory using interactive search.                                                                                                                                                 
function __zoxide_zi() {                                                                                                                                                                        
    \builtin local result                                                                                                                                                                       
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"                                                                                                          
}                                                                                                                                                                                               
                                                                                                                                                                                                
# Completions.                                                                                                                                                                                  
if [[ -o zle ]]; then                                                                                                                                                                           
    function __zoxide_z_complete() {                                                                                                                                                            
        # Only show completions when the cursor is at the end of the line.                                                                                                                      
        # shellcheck disable=SC2154                                                                                                                                                             
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return 0                                                                                                                                       
                                                                                                                                                                                                
        if [[ "${#words[@]}" -eq 2 ]]; then                                                                                                                                                     
            _files -/                                                                                                                                                                           
        elif [[ "${words[-1]}" == '' ]] && [[ "${words[-2]}" != "${__zoxide_z_prefix}"?* ]]; then                                                                                               
            \builtin local result                                                                                                                                                               
            # shellcheck disable=SC2086,SC2312                                                                                                                                                  
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" --interactive -- ${words[2,-1]})"; then                                                                              
                result="${__zoxide_z_prefix}${result}"                                                                                                                                          
                # shellcheck disable=SC2296                                                                                                                                                     
                compadd -Q "${(q-)result}"                                                                                                                                                      
            fi                                                                                                                                                                                  
            \builtin printf '\e[5n'                                                                                                                                                             
        fi                                                                                                                                                                                      
        return 0                                                                                                                                                                                
    }                                                                                                                                                                                           
                                                                                                                                                                                                
    \builtin bindkey '\e[0n' 'reset-prompt'                                                                                                                                                     
    [[ "${+functions[compdef]}" -ne 0 ]] && \compdef __zoxide_z_complete __zoxide_z           
fi                                                                                            
                                                                                              
# =============================================================================               
#                                                                                             
# Commands for zoxide. Disable these using --no-cmd.                                          
#                                                                                             
                                                                                              
\builtin alias z=__zoxide_z                                                                   
\builtin alias zi=__zoxide_zi                                                                 
                                                                                              
# =============================================================================               
#                                                                                             
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):                    
#                                                                                             
eval "$(zoxide init zsh)"      

eval "$(starship init zsh)" # keep at the end of all lines
