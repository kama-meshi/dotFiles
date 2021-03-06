random_cowsay() {
    # Only brew user!
    # If you are not brew user, change 'COWS' path
    COWS=`brew --prefix`/Cellar/cowsay/3.03/share/cows
    NBRE_COWS=$(ls -1 $COWS | wc -l | tr -d ' ')
    COWS_RANDOM=$(expr $RANDOM % $NBRE_COWS + 1)
    COW_NAME=$(ls -1 $COWS | awk -F\. -v COWS_RANDOM_AWK=$COWS_RANDOM 'NR == COWS_RANDOM_AWK {print $1}')
    echo "[COW:${COW_NAME}]"
    cowsay -f $COW_NAME "`Fortune -s`"
}
if which fortune cowsay >/dev/null; then
    while :
    do
        random_cowsay 2>/dev/null && break
    done
fi && unset -f random_cowsay
