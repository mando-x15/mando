1. Download it
wget http://www.ibiblio.org/pub/Linux/utils/file/managers/mc/mc-4.6.1.tar.gz

2. Extact
tar zvfx mc-4.6.1.tar.gz

3. CD
cd mc-4.6.1

4. Configure make and make install
./configure --prefix=/home1/02143/spfeife/mc-4.6.1 && make && make install




# create wrapper:

cd bin
touch mc-wrapper.sh

```bash
MC_USER=`id | sed 's/[^(]*(//;s/).*//'`
MC_PWD_FILE="${TMPDIR-/tmp}/mc-$MC_USER/mc.pwd.$$"
/home1/02143/spfeife/mc-4.6.1/bin/mc -P "$MC_PWD_FILE" "$@"

if test -r "$MC_PWD_FILE"; then
        MC_PWD="`cat "$MC_PWD_FILE"`"
        if test -n "$MC_PWD" && test -d "$MC_PWD"; then
                cd "$MC_PWD"
        fi
        unset MC_PWD
fi

rm -f "$MC_PWD_FILE"
unset MC_PWD_FILE

```

#make mc.sh

touch mc.sh
```
alias mc='. /home1/02143/spfeife/mc-4.6.1/bin/mc-wrapper.sh'
```
