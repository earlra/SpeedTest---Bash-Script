#write the headers, when needed
#echo "Date;Time;Ping;Download:Upload" > speeds.csv
#sed -i -e '$a\' speeds.csv
#NOTE - use the echo only once; overwrites the file, but only needed the first time.
#date +%Y-%m  | tr '\n' ';' >>speeds.csv && date +"%T" | tr '\n' ';' >>speeds.csv && speedtest-cli --simple | tr '\n' ';' >>speeds.csv && sed -i -e '$a\' speeds.csv
# The above line works as a single line.
#Now we need to see if we can split this up for readability
date +%Y-%m  | tr '\n' ',' >>speeds.csv
date +"%T" | tr '\n' ',' >>speeds.csv
#speedtest-cli --simple | tr '\n' ';' >>speeds.csv
#trying to see if can output to a variable we can break down piece by piece
results=$(speedtest-cli --simple)
#echo "ping is "${results:6:7}
#checking to see if we have a string we can work with
#echo $results
#$results | tr '\n' ';' >>speeds.csv
# didn't work: $ping | tr '\n' ';' >>speeds.csv
#below line works, but text not stripped yet:
#speedtest-cli --simple | tr '\n' ';' >>speeds.csv
#so now trying to use the above line to populate a variable we can work with
concat=$(speedtest-cli --simple | tr '\n' ',')
# we can use fixed length to separate ping time (although trailing spaces?).
#pingtime=$concat | awk '{printf $2}'
download=$concat | awk '{printf $4}'
#upload=$concat | awk '{printf $6}'
#echo "pingtime is " $pingtime
# echo line below works, just use for testing
#echo "concat is " $concat
#below line works for appending the speedtest results string from a variable, now just need to clean up that variable...
#echo $concat >>speeds.csv
#below is trying to send one variable at a time, stipped cleanly
#below works!
#echo $concat | awk '{printf $2}'>>speeds.csv
#echo $pingtime >>speeds.csv
#printf "," >>speeds.csv
echo $concat | awk '{printf $4}'>>speeds.csv
#printf "," >>speeds.csv
#echo $concat | awk '{printf $6}'>>speeds.csv
#echo ";" >>speeds.csv
sed -i -e '$a\' speeds.csv
# the above work as multiple lines, next need to clean out strings
