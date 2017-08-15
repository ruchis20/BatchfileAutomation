TEST_SL_NO=$2
TEST_NAME=`echo $3 | sed 's/_/ /g' `
TEST_START_DATE=`echo $4 | sed 's/_/ /g' `
TEST_END_DATE=`echo $5 | sed 's/_/ /g' `
TEST_STATUS="$6 -- $7"
ERROR_DETAILS=`echo $8 | sed 's/_/ /g' `
EXEC_START_DATE=`echo $9 | sed 's/_/ /g' `
OUT_FILE=$1
shift
EXEC_END_DATE=`echo $9 | sed 's/_/ /g' `
echo "$TEST_SL_NO,$TEST_NAME,$TEST_START_DATE,$TEST_END_DATE,$EXEC_START_DATE,$EXEC_END_DATE,$TEST_STATUS,$ERROR_DETAILS">>$OUT_FILE
