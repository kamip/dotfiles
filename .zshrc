export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/local/bin:$PATH"

PROMPT="%/%% "

alias be='bundle exec'
alias vi='vim'
alias rspec='bundle exec rspec'

fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u

