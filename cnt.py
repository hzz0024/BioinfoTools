import numpy as np
import re

fileName = './Flowcell1_1_fastq'
fileInput = open(fileName, mode='r')
#chars = set('!"#$%&'()*+,-./')
chars = set('\'"!#$%&()*+/,-.012')
cnt = 0
for strLine in fileInput:
    #Strip the endline character from each input line
    strLine = strLine.rstrip("\n")
    if strLine.startswith("EEEE"):
        strLine=strLine[0:64]
        if any((c in chars) for c in strLine):
            cnt += 1 
	    
print('Count: ' + str(cnt))