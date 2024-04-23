#!/bin/bash

set -eu
echo "max msg $MAX_MSG"
BUCKET=bmpd-kafka-backup/
TIME=$(date +"%Y-%m-%d-%I-%M-%S-%p")
DATE=$(date +"%Y-%m-%d")
KAFKA_HOME=/var/task/kafka/kafka/
LOG_FILE=/tmp/s3-backup/$TIME.txt
CONSUMER_GROUP="oag-s3-backup"
BOOTSTRAP_SERVER="kafka.bmpdtravel.com:9092"
#TIMEOUT="10000"
MAX_MESSAGE=$MAX_MSG
# Retrieve the list of topics


topics=$($KAFKA_HOME/bin/kafka-topics.sh --list --bootstrap-server kafka.bmpdtravel.com:9092)
# Loop through each topic and consume messages
for topic in $topics; do
    if [ "$topic" == "bumpd.oag.events" ]; then
        #echo "--------------------------------------" >> $LOG_FILE
        #echo "$topic" >> $LOG_FILE
        #echo "--------------------------------------" >> $LOG_FILE
        $KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server $BOOTSTRAP_SERVER --topic $topic --consumer-property group.id=$CONSUMER_GROUP --max-messages $MAX_MESSAGE >> $LOG_FILE
        #echo "--------------------------------------" >> $LOG_FILE
    fi
done

# Compress the log file
gzip $LOG_FILE


# Upload gzip to s3
aws s3 cp $LOG_FILE.gz s3://$BUCKET$DATE/

# Remove gzip file locally
/usr/bin/rm -f $LOG_FILE.gz

echo "Kafka messages backup available at https://s3.amazonaws.com/$BUCKET/$DATE/$TIME.txt.gz"

