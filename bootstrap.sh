# download the install the oh-my-zsh bits
ZSH_HOME=$HOME/.oh-my-zsh
REPO_HOME=$HOME/dotfiles

# install configuration files from a download rather than git
function installZSH() {
    if [ -d $ZSH_HOME ]
    then
        echo "OH MY ZSH is already installed.  Please remove $ZSH_HOME to proceed."
        exit
    fi

    git clone git://github.com/robbyrussell/oh-my-zsh.git $ZSH_HOME
    
    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]
    then
        cp ~/.zshrc ~/.zshrc.orig
    fi

    cp $ZSH_HOME/templates/zshrc.zsh-template ~/.zshrc

    cat $REPO_HOME/.oh-my-zsh/custom/functions.zsh

    chsh -s `which zsh`
    
    /usr/bin/env zsh
    
    source ~/.zshrc

    source $REPO_HOME/.oh-my-zsh/custom/functions.zsh
    
    cat $REPO_HOME/.oh-my-zsh/custom/functions.zsh

    syncRepo2
}

installZSH
