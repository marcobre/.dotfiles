
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="half-life"

plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
#pokemon-colorscripts --no-title -s -r #without fastfetch
#pokemon-colorscripts --no-title -s -r | fastfetch -c $HOME/.config/fastfetch/config-pokemon.jsonc --logo-type file-raw --logo-height 10 --logo-width 5 --logo -

# fastfetch. Will be disabled if above colorscript was chosen to install
fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc

# Set-up icons for files/directories in terminal using lsd
#alias ls='lsd'
#alias l='ls -l'
#alias la='ls -a'
#alias lla='ls -la'
#alias lt='ls --tree'
# source zoxide to replace cd with it
eval "$(zoxide init zsh)"

# source user aliases
source $HOME/.config/aliases


# FZF Stuff
#
# source fzf functions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Preview file content using bat in CTRL+T 

export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# show hidden files/folders per default
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'

# ripgrep config
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi


# More fzf utils
function check_req () {
    $(type bat > /dev/null 2>&1) && $(type fd > /dev/null 2>&1) && $(type fzf > /dev/null 2>&1)
}

function fzf-nvim () {
    if $(check_req); then
        
        local selected_file=$( \
            fd --type f \
            --hidden \
            --follow \
            --max-depth 5 \
            --exclude .git | \
            
            fzf \
            --info inline \
            --bind 'ctrl-d:preview-down,ctrl-u:preview-up' \
            --bind='?:toggle-preview' \
            --preview "bat --style=numbers --theme=darkneon --color=always {} | head -500" \
            --color=dark \
            --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
            --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
            --query "$LBUFFER" --prompt="nvim file > "

        )
        
        if [ -n "$selected_file" ]; then
            BUFFER="nvim-lazy $selected_file"
            zle accept-line
        fi
        zle reset-prompt
        
    fi
}

function fzf-cd () {
    if $(check_req); then
        
        local selected_file=$( \
            fd --type d \
            --max-depth 5 \
            --hidden \
            --follow \
            --exclude .git | \
            
            fzf --preview "lsd -l --blocks=permission,name {} | head -50" \
            --bind 'ctrl-d:preview-down,ctrl-u:preview-up' \
            --bind='?:toggle-preview' \
            --info inline \
            --color=dark \
            --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f \
            --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7 \
            --query "$LBUFFER" --prompt="Change dir to > "
        )
        
        if [ -n "$selected_file" ]; then
            BUFFER="cd $selected_file"
            zle accept-line
        fi
        zle reset-prompt
        
    fi
}

function nmail() {
    set -o pipefail
    mail=$(notmuch show --format=text \
                   $(notmuch search date:1970..2025 | \
                         fzf --reverse --preview \
                             "echo {} | cut -d' ' -f1 | cut -d':' -f2 | \
xargs notmuch show --format=text | \
grep 'message{' | head -n 1 | cut -d':' -f6,7 | \
sed 's/\ /\\\ /g' | xargs mu view" | \
                         cut -d' ' -f1 | cut -d':' -f2) | \
               grep 'message{' | head -n 1 | cut -d':' -f6,7 | \
               sed 's/\ /\\\ /g' | xargs mu view) && \
        echo $mail | nvim -c 'set ft=mail' -c 'nmap q :q!<CR>'
}

zle -N nmail
zle -N fzf-cd
zle -N fzf-nvim
bindkey '^F' fzf-cd
bindkey '^K' fzf-nvim
bindkey '^N' nmail
# Enable autocompletation again
source ~/.fzf/shell/completion.zsh

export PATH=$HOME/.toolbox/bin:$PATH


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"

# Added by AIM CLI
export PATH="$HOME/.aim/mcp-servers:$PATH"
