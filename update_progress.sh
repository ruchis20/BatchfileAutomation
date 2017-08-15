date_str=`date "+%Y-%m-%d %H:%M:%S"`
date_str2="Last_update_date: $date_str, Status:"
if [ "$3"  = "Start" ]
then
  status_str="Test_no: $2 under process"
  echo "$date_str2 $status_str" >>$1
fi
if [ "$3"  != "Start" ]
then
  status_str="$3 -- $4"
  echo "$date_str2 $status_str" >>$1
fi
