#!/bin/bash
if [ $(docker images | grep -c "valkyrie-app.*v0.0.1") -eq 1 ]
then
    echo Image exists
    echo ok > /tmp/ok
    gsutil cp /tmp/ok gs://${GOOGLE_CLOUD_PROJECT}-marking/step1 >& /dev/null
    echo Go ahead and check the activity tracking on the lab page
else
    echo Image not found
    gsutil rm gs://${GOOGLE_CLOUD_PROJECT}-marking/step1 >& /dev/null
    echo Are you sure you tagged the image correctly? it should be valkyrie-app:v0.0.1
fi

