TMP_DIR=$1
OUT_DIR=$2
TEST_SL_NO=$3
VERIFY1_COMP_OP=$4
VERIFY1_COMP_TYP=$5
VERIFY1_FILE=$6
VERIFY1_SEPARATOR=$7
VERIFY1_LINE_NO=$8
VERIFY1_COLUMN_NO=$9
shift
shift
VERIFY1_COLUMN_CNT=$8
VERIFY1_FILTER=$9
echo "$TMP_DIR,$OUT_DIR,$TEST_SL_NO,$VERIFY1_COMP_OP,$VERIFY1_COMP_TYP,$VERIFY1_FILE,$VERIFY1_SEPARATOR,$VERIFY1_LINE_NO,$VERIFY1_COLUMN_NO,$VERIFY1_COLUMN_CNT,$VERIFY1_FILTER" >>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
VERIFY1_SEP=`echo VERIFY1_SEPARATOR | cut -c1`
if [ "$VERIFY1_SEP" = "(" ]
then
   VERIFY1_SEP=" "
fi
SUFFIX=".test"
FILE1="$TMP_DIR/$TEST_SL_NO$SUFFIX"
FILE2="$OUT_DIR/$VERIFY1_FILE"
echo "$FILE1,$FILE2,$VERIFY_SEP">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
if [ ! -f $FILE1 ]
then
>&2 echo "$FILE1 not found"
   exit 1
fi
if [ ! -f $FILE2 ]
then
>&2 echo "$FILE2 not found"
   exit 1
fi
if [ -z "$VERIFY1_LINE_NO" ]
then
   VALUE1=`cat $FILE1`
   VALUE2=`cat $FILE2`
   echo "line no null">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$FILE1,$VALUE1">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$FILE2,$VALUE2">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$VALUE2,$VALUE1">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
else
   VALUE1=`cat $FILE1`
   line_no=0
   cat FILE2 | 
   while read line
   do
   line_no=`expr $line_no + 1`
   if [ "$line_no" = "$VERIFY1_LINE_NO" ]
   then
        ROW1=$line
   fi
   done
   cnt=1
   columns="$VERIFY1_COLUMN_NO"
   while [ $cnt -lt $VERIFY_COLUMN_CNT ]
   do
     VERIFY1_COLUMN_NO=`expr $VERIFY1_COLUMN_NO + 1`
     cnt=`expr $cnt + 1`
     columns="$columns,$VERIFY1_COLUMN_NO"
   done
   VALUE2=`echo $ROW1 | cut -d$VERIFY1_SEP -f$columns`
   echo "line no exists:$VERIFY_LINE_NO">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$FILE1,$VALUE1">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$FILE2,$VALUE2">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
   echo "$VALUE2,$VALUE1">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
fi
if [ "$VERIFY1_COMP_TYP" = "Numeric" ]
then
   if [ -z "$VALUE1" -a -n "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match"
   exit 1
   fi
   if [ -n "$VALUE1" -a -z "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match"
   exit 1
   fi
   if [ -z "$VALUE1" -a -z "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match both null"
   exit 1
   fi
   if [ "$VERIFY1_COMP_OP" = "equal_to" ]
   then
   if [ $VALUE1 -eq $VALUE2 ]
   then
      echo "number check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
   fi
   if [ "$VERIFY1_COMP_OP" = "equal_to_greater_than" ]
   then
   if [ $VALUE1 -ge $VALUE2 ]
   then
      echo "number check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
   fi
   if [ "$VERIFY1_COMP_OP" = "equal_to_less_than" ]
   then
   if [ $VALUE1 -le $VALUE2 ]
   then
      echo "number check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
   fi
   if [ "$VERIFY1_COMP_OP" = "greater_than" ]
   then
   if [ $VALUE1 -gt $VALUE2 ]
   then
      echo "number check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
   fi
   if [ "$VERIFY1_COMP_OP" = "less_than" ]
   then
   if [ $VALUE1 -lt $VALUE2 ]
   then
      echo "number check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
   fi
fi
if [ "$VERIFY1_COMP_TYP" = "Character" -a "$VERIFY1_COMP_OP" = "equal_to" ]
then
   if [ -z "$VALUE1" -a -n "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match"
   exit 1
   fi
   if [ -n "$VALUE1" -a -z "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match"
   exit 1
   fi
   if [ -z "$VALUE1" -a -z "$VALUE2" ]
   then
>&2 echo "VALUE1:$VALUE1 and VALUE2:$VALUE does not match both null"
   exit 1
   fi
   if [ "$VALUE1" = "$VALUE2" ]
   then
      echo "Character check test_success">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
     exit 0
   fi
fi
echo "misc: test_failed">>/home/sankar/Pentaho/rucks/test_auto/status/debug.txt
exit 1
