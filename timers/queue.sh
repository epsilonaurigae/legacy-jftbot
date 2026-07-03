#!/bin/bash
:> ~/tmp/workqueue.bx
cat ~/tmp/workqueue.tmp |awk '!seen[$0]++' | \
while read line ; do
        echo "$line" >> ~/tmp/workqueue.bx
	sed -i '1d' ~/tmp/workqueue.tmp
done
exit


