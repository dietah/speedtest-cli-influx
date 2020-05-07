#!/bin/sh

while true
do
	resuls=`/app/speedtest/speedtest-cli --csv`

IFS=',' read -r serverid sponsor name timestamp distance ping download upload share ip <<-_EOF_
$resuls
_EOF_

	data="speedtest,server=$serverid,sponsor=$sponsor,name=$name,ip=$ip ping=$ping,download=$download,upload=$upload,distance=$distance"
	curl -XPOST --no-progress-meter "http://$DB_HOST/api/v2/write?bucket=$DB_NAME" --data-raw "$data" -w "Result written to Influx, took %{time_total}s"
	echo
	echo "Ping: $ping Download: $download - Upload: $upload  @  $timestamp"

	sleep $TEST_INTERVAL
done
