MC_USER=`id | sed 's/[^(]*(//;s/).*//'`
MC_PWD_FILE="/home/spfeife/mc-4.6.1/temp/mc.pwd.$$"
/home/spfeife/mc-4.6.1/bin/mc -P "$MC_PWD_FILE" "$@"

if test -r "$MC_PWD_FILE"; then
        MC_PWD="`cat "$MC_PWD_FILE"`"
        if test -n "$MC_PWD" && test -d "$MC_PWD"; then
                cd "$MC_PWD"
        fi
        unset MC_PWD
fi

rm -f "$MC_PWD_FILE"
unset MC_PWD_FILE

