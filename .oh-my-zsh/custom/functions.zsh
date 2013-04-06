REPO_HOME=$HOME/dotfiles

# sync up the dotfiles repo
function syncrepo() {
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
                mkdir -p $dir
            fi
            ln -sf $current $new
        fi
    done
    popd
}

# send content to pastebin
function pastebin() {
    curl -s -X POST -d "api_option=paste&api_dev_key=$PB_API_KEY&api_paste_code=$1" "http://pastebin.com/api/api_post.php"
}

# calculate percent of 100
function pero() {
    result=`echo "scale=2;($1*100)/$2" | bc`
    echo "$result%"
}

# calculate percent of change
function perc() {
    result=`echo "scale=2;(($2 - $1) / $1)*100" | bc`
    echo "$result%"
}
