# modified on 20171026 to add hour and IP address
#install info on: https://www.howtoforge.com/tutorial/check-internet-speed-with-speedtest-cli-on-ubuntu/
#then will need to make the file executable
#write the headers, when needed
#echo "IP,Date,Day,Time,Hour,Download,Upload" > speeds.csv
#IP address so I can see where I am checking, and also check IP address changes at home
dig +short myip.opendns.com @resolver1.opendns.com  | tr '\n' ',' >>speeds.csv
#date string
date +%Y-%m-%d  | tr '\n' ',' >>speeds.csv
#And add day of week so can look at weekdays vs weekends
date +%u  | tr '\n' ',' >>speeds.csv
#then add time
date +"%T" | tr '\n' ',' >>speeds.csv
#then add hour, so can look at averages per hour of the day
date +"%H" | tr '\n' ',' >>speeds.csv
#speedtest-cli --simple | tr '\n' ';' >>speeds.csv
#trying to see if can output to a variable we can break down piece by piece
results=$(speedtest-cli --simple)
#echo "ping is "${results:6:7}
#below line works, but text not stripped yet:
#speedtest-cli --simple | tr '\n' ';' >>speeds.csv
#so now trying to use the above line to populate a variable we can work with
concat=$(speedtest-cli --simple | tr '\n' ',')
# we can use fixed length to separate ping time (although trailing spaces?).
#pingtime=$concat | awk '{printf $2}'
#download=$concat | awk '{printf $4}'
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
#download speed and add to file
echo $concat | awk '{printf $4}'>>speeds.csv
#add comma for next field
printf "," >>speeds.csv
#Upload speed
echo $concat | awk '{printf $6}'>>speeds.csv
#next print end of line
printf '\n' >>speeds.csv
