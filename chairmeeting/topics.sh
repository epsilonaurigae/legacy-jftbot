#!/bin/bash
TOPIC=`/usr/bin/sort -R ~/topics/discussiontopics.txt |head -1`
echo "/say Our randomly selected topic is: $TOPIC" >> ~/tmp/workqueue.tmp
echo "/say Feel free to share about this, or wherever you are in your recovery today." >> ~/tmp/workqueue.tmp
echo "/topic #nachat $TOPIC" >> ~/tmp/workqueue.tmp
