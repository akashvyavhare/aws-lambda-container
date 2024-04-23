function handler () {
    EVENT_DATA=$1

    RESPONSE="{\"statusCode\": 200, \"body\": \"Hello from Lambda!\"}"
    mkdir /tmp/s3-backup/
    /var/task/script.sh

    
}
