#!/bin/bash

cd data/finalproject

ls Driver/c0/ | while read photo; do
	echo `readlink -n -e Driver/c0/$photo` 0
done > new.test
