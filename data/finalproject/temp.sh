 #!/bin/bash

cat=c0
ls images/$cat/ | while read photo; do
	echo `readlink -n -e images/${cat}/$photo` `expr 1 - 1`
done
