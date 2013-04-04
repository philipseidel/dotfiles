REPO_HOME=$HOME/dotfiles

function updateFiles() {
    pushd $REPO_HOME
    for file in `find . | grep -vE '(\.git|\.DS_Store|\.swp|README\.md|bootstrap\.sh)'`
    do
        if [ -f "$file" ]
        then
            current=`echo $file | sed "s;./;$REPO_HOME/;"`
            new=`echo $current | sed "s;$REPO_HOME;$HOME;"`
            dir=`dirname $new`
            if [ ! -d $dir ]
            then
                echo mkdir -p $dir
            fi
            echo ln -sf $current $new
        fi
    done
    popd
}

updateFiles
