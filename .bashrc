# ~/.bashrc

[[ $- != *i* ]] && return

# Aliases
alias fzf="fzf --color=dark,fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe,info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef "
alias fd="find / -type d -print | fzf"
alias ff="fzf"
alias fz="fzf"
alias tree="exa --tree -a --icons"
alias ls="exa -a --icons --color=auto --group-directories-first"
alias la="exa -la --icons --color=auto --group-directories-first"
alias l="exa -a --icons --color=auto --group-directories-first"
alias grep="rg --color=auto"
alias cat="bat"
alias du="dust"
alias c="clear"
alias scl="clear && history -c && echo "" > ~/.bash_history"
alias nv="nvim"
alias ..="cd .."
alias back="cd '$OLDPWD'"
alias :q="exit"
alias :wq="exit"
alias sudo="doas"
alias cb="xsel -bc"
alias firefox="TZ=UTC firefox"
alias tor="cd /opt/tor ; TZ=UTC /opt/tor/start-tor-browser.desktop"
alias ss="flameshot gui"
alias serve="python -m http.server 30000"
alias neofetch="neofetch --ascii ~/.config/neofetch/logo.txt"

# Colored PS1
export PS1="\[\033[38;5;208m\][\[$(tput sgr0)\]\[\033[38;5;41m\]\A\[$(tput sgr0)\]\[\033[38;5;208m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;208m\][\[$(tput sgr0)\]\[\033[38;5;148m\]\w\[$(tput sgr0)\]\[\033[38;5;208m\]]\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;208m\]❯\[$(tput sgr0)\] "

export EXA_COLORS="di=38;5;161:fi=38;5;173"

. "$HOME/.cargo/env"
source ~/.config/alacritty/alacritty_completions
source ~/.cargo/cargo_completions
