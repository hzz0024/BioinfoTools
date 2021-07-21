import numpy as np
import re
import argparse


arg_parser = argparse.ArgumentParser()
arg_parser.add_argument(
        '--input',
        default='./Flowcell1_1_fastq',
        help='Input file.')
args = arg_parser.parse_args()

# replace the fileName with your own fastq file name
fileName = args.input
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
