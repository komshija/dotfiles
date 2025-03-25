if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='vim'

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git 
  zsh-syntax-highlighting 
  zsh-autosuggestions 
  zsh-ssh)

source $ZSH/oh-my-zsh.sh

# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias c="clear"
alias src="cd ~/source"
alias env="source ./bin/activate"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
