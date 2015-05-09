set -o vi

export TZ='Europe/Stockholm'
[ -n "$(command -v "nvim")" ] && export EDITOR="nvim" || export EDITOR="vim"
[ -d $HOME/.gem/ruby/1.9.1/bin ] && PATH=$HOME/.gem/ruby/1.9.1/bin:$PATH
export GOPATH=$HOME/go
export PATH=$HOME/.cabal/bin:$HOME/git/utils:$HOME/bin:/usr/lib/ccache/bin/:$GOPATH/bin:/usr/local/bin/:$PATH
#[ $OSX -gt 0 ] && export PATH="$(brew --prefix homebrew/php/php55)/bin:$PATH"
export PAGER="less"

# Load completions
for d in $ZSH_HOME/completion/*(/); do
    [[ -d $d/src ]] && dir=$d/src || dir=$d
    [[ $DEBUG -gt 0 ]] && echo "zsh: adding dir to \$fpath $dir"
    fpath=($dir $fpath)
done

[ -n "$(command -v "keychain")" ] && eval $(keychain --eval --agents ssh -Q --quiet id_rsa)

if [ -f $HOME/git/configs/base16-builder/output/shell/base16-monokai.dark.sh ]; then
    sh $HOME/git/configs/base16-builder/output/shell/base16-monokai.dark.sh
fi

# Load colors before we source all config-files that might use them
autoload -U colors
colors
autoload -U compinit
compinit -i
zmodload zsh/complist
autoload edit-command-line
zle -N edit-command-line

setopt extended_glob
setopt brace_ccl # Nifty stuff like {a-z} to complement {1..15}
setopt auto_cd
setopt auto_pushd
setopt pushd_silent
setopt prompt_subst
setopt hash_cmds
setopt auto_list

# Virtualenv
if [ -f "/usr/local/bin/virtualenvwrapper.sh" -a $OSX -gt 0 ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
    export WORKON_HOME=$HOME/Envs
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Load libraries
for f in $ZSH_HOME/lib/*.zsh; do
    [[ $DEBUG -gt 0 ]] && echo "zsh: sourcing library $f"
    source $f
done

[[ -f $ZSH_HOME/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source $ZSH_HOME/modules/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load gistit token if available
[[ -f $HOME/.gistitrc ]] && source $HOME/.gistitrc
