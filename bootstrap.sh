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

    # link to the repo zsh config
    ln -sf $REPO_HOME/.zshrc $HOME/.zshrc 

    chsh -s `which zsh`
    
    /usr/bin/env zsh
    
    source ~/.zshrc

} 

installZSH
