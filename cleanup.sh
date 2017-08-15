rm -rf /home/sankar/Pentaho/rucks/test_auto/status/*
rm -rf /home/sankar/Pentaho/rucks/test_auto/tmp/*
rm -rf /home/sankar/Pentaho/rucks/test_auto/out_files/*
echo line1
echo line2
>&2 echo "error_line1"
>&2 echo "error_line2"
exit 0
