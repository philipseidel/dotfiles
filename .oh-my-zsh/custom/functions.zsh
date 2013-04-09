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

# return a range of properly padded numbers
function range() {
    if [ $2 -lt 10 ]
    then
        flags='-f %02G'
    else
        flags='-w'
    fi

    if [ `uname` = "Darwin" ]
    then
        # os x uses gnu coreutils
        gseq $flags $1 $2
    else
        seq $flags $1 $2
    fi
}

# get a list of ip addresses with host names
function lookup() {
    for i in `range $2 $3`
    do
        host="$1$i$4"
        ip=`dig +nocmd +nostats +nocomments +nomultiline $host | grep -Eo "([0-9]+\.[0-9]+\.)[0-9]+\.[0-9]+"`
        echo "$host,$ip"
    done;
}

# get a list of ip addresses 
function iplist() {
    for i in `lookup $1 $2 $3 $4`
    do    
        result=`echo "$i" | cut -d "," -f 2`
        if [ "$output" = "" ]
        then
            output="$result"
        else
            output="$output $result"
        fi
    done
    echo $output
}

