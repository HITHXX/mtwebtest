#/usr/bin/env bash

METEOR=$(dirname $0)/../meteor-*.jar
FMT=$(dirname $0)/wmt_fmt.py

if [[ $# != 1 ]] ; then
    echo "Score an entire WMT evaluation"
    echo "Usage: $0 <plain-dir>"
    echo "where plain-dir contains: references system-outputs"
    exit 1
fi

PLAIN=$1

for SET in $(ls $PLAIN/system-outputs) ; do
    for LANG in cs de es fr ; do
        echo "$LANG-en:"
        for HYP in $PLAIN/system-outputs/$SET/$LANG-en/* ; do
            SYS=$(echo $HYP | sed -re 's/.+\.//')
            echo " $SYS"
            java -Xmx2G -jar $METEOR $HYP $PLAIN/references/$SET-ref.en -l en -norm | $FMT $LANG-en $SET $SYS Meteor
        done
    done
    for LANG in cs de es fr ; do
        echo "en-$LANG"
        for HYP in $PLAIN/system-outputs/$SET/en-$LANG/* ; do
            SYS=$(echo $HYP | sed -re 's/.+\.//')
            echo " $SYS"
            java -Xmx2G -jar $METEOR $HYP $PLAIN/references/$SET-ref.$LANG -l $LANG -norm | $FMT en-$LANG $SET $SYS Meteor
        done
    done
done
