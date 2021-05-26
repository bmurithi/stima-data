#!/bin/sh

if [ ! -d /var/prometheus ]; then
    mkdir /var/prometheus
fi

# !!!!CHANGE THIS
DEVICE_IP=""
CONTENT_TYPE='Content-type:text/xml;  charset=utf-8'
SOAP_ACTION='SOAPACTION:"urn:Belkin:service:insight:1#GetInsightParams"'

DATA=$(cat <<EOF
<?xml version="1.0" encoding="utf-8"?>
  <s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/"
    s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
     <s:Body>
       <u:GetInsightParams xmlns:u="urn:Belkin:service:insight:1">
       </u:GetInsightParams>
     </s:Body>
  </s:Envelope>
EOF
)

[ -z "$DEVICE_IP" ] && {
	echo "You must define the wemo switch AP"		
	exit 1
}


DATE=$(date +"%Y-%m-%d")
INSIGHT_FILE="/tmp/insight.data"
DEVICE_PORT=

for upnp_port in 49151 49152 49153 49154 49155 49156 49157 49158;
do
        URL="http://$DEVICE_IP:$upnp_port/setup.xml"
        curl --max-time 1 -I --silent --output /dev/null "$URL"
        if [ $? -eq 0  ];
	then
                DEVICE_PORT="$upnp_port"
                break
        fi
done

[ -z "$DEVICE_PORT" ] && {
	echo "Failed to find open port on wemo"		
	exit 1
}

curl -H "$CONTENT_TYPE" -H "$SOAP_ACTION" --max-time 1 --silent \
	-d "$DATA" --output ${INSIGHT_FILE} "http://${DEVICE_IP}:${DEVICE_PORT}/upnp/control/insight1"

if [ $? -eq 0 ]; 
then
	metrics=$(cat ${INSIGHT_FILE} \
		| grep "<InsightParams>" \
		| sed -r "s|<(/){0,1}InsightParams>||g" \
		| awk -v dt="$DATE" -F\| -e '{print "current_power{d=\""dt"\"} "$8/1000"\nenergy_today{d=\""dt"\"} "$9*0.000000016666667;}'
	)
fi



OUT_FILE="$1"
OUT_FILE=${OUT_FILE:-$(mktemp)}
echo "Dumping metrics to $OUT_FILE"

cat <<EOF >$OUT_FILE
# TYPE current_power gauge
# TYPE energy_today gauge
# TYPE wemo_port gauge
$metrics
wemo_port $DEVICE_PORT
EOF

