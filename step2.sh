#!/bin/bash
HTTP=$(curl -I 127.0.0.1:8080 2> /dev/null | grep -c "200 OK")
DOCKER=$(docker ps | grep -c "valkyrie-app:v0.0.1")
if [  $DOCKER -eq 1 ]
then
    if [ $HTTP -eq 1 ] 
    then
        echo Container running and visible on port 8080, good job!
        echo ok > /tmp/ok
        gsutil cp /tmp/ok gs://${GOOGLE_CLOUD_PROJECT}-marking/step2 >& /dev/null
        echo Go ahead and check the activity tracking on the lab page
    else
        echo The container is running, but the website is not published on port 8080 
        gsutil rm gs://${GOOGLE_CLOUD_PROJECT}-marking/step2 >& /dev/null
        echo Did you publish port 8080 to port 8080?
    fi
else
    echo No container running
    gsutil rm gs://${GOOGLE_CLOUD_PROJECT}-marking/step2 >& /dev/null
    echo Are you sure you ran the image?
fi
