# download the install the oh-my-zsh bits
ZSH_HOME=$HOME/tmp
REPO_HOME=$HOME/dotfiles

function updateZSH() {
    #echo $HOME
    pushd $ZSH_HOME
    curl "https://nodeload.github.com/robbyrussell/oh-my-zsh/tar.gz/master" | tar xvz
    mv ./oh-my-zsh-master ./.oh-my-zsh
    popd
}

#updateZSH

# just a quick function to sync up the repo
function updateFiles() {
    pushd $REPO_HOME
    for file in `find . | grep -vP '(\.git|\.DS_Store|\.swp)'`
    do
        if [ "$file" != "." ]
        then
            new=`echo $file | sed "s;./;$HOME/;"`
            dir=`dirname $new`
            if [ ! -d $dir ]
            then
                echo mkdir -p $dir
            fi

            echo cp -f $file $new
        fi
    done
    
    popd
}

updateFiles
