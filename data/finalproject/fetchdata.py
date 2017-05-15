import csv
with open('driver_imgs_list.csv','r') as imglist:
    input = csv.reader(imglist, delimiter=',')
    headers = input.next()
    with open('train.txt','w+') as output:
    	for line in input:
	    output.write(line[2]+" "+line[1][-1:]+"\n")
