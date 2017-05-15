#!/usr/bin/python
import sys
import os

acc = 0.0
c = 0.0
confMatrix = [[ 0 for i in range(10)] for j in range(10)]

for file in os.listdir(sys.argv[1]):
	path = sys.argv[1]+file
	with open( path, 'r') as fin:
		for line in fin:
			l = line.split()
			c += 1
			if ( l[1] == l[2]):
				acc += 1
			else:
				print line
			confMatrix[ int( l[1] ) ] [ int( l[2] ) ] += 1

acc = acc/c

print "Accuracy = " , acc*100

for r in confMatrix:
	print r

