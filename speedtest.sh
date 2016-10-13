#write the headers, when needed
#echo "Date;Time;Ping;Download:Upload" > speeds.csv
#sed -i -e '$a\' speeds.csv
#NOTE - use the echo only once; overwrites the file, but only needed the first time.
#date +%Y-%m  | tr '\n' ';' >>speeds.csv && date +"%T" | tr '\n' ';' >>speeds.csv && speedtest-cli --simple | tr '\n' ';' >>speeds.csv && sed -i -e '$a\' speeds.csv
# The above line works as a single line.
#Now we need to see if we can split this up for readability
date +%Y-%m  | tr '\n' ';' >>speeds.csv
date +"%T" | tr '\n' ';' >>speeds.csv
#speedtest-cli --simple | tr '\n' ';' >>speeds.csv
#trying to see if can output to a variable we can break down piece by piece
results=$(speedtest-cli --simple)
#checking to see if we have a string we can work with
#echo $results
#$results | tr '\n' ';' >>speeds.csv
# didn't work: $ping | tr '\n' ';' >>speeds.csv
speedtest-cli --simple | tr '\n' ';' >>speeds.csv
sed -i -e '$a\' speeds.csv
# the above work as multiple lines, next need to clean out strings
