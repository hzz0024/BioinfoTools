# BioinfoTools

The repository is a library of bioinformatics tools for data analyses and visualization.

## Table Of Content

  - [Data Analysis](#data-analysis)
  - [Plotting](#plotting)

## Data Analysis

[getseq.pl](https://github.com/hzz0024/BioinfoTools/blob/master/Perl_script/getseq.pl) [perl] : extract the target sequence based on a list of IDs. 
```
USAGE
  $ perl getseq.pl [list of IDs] [seq.fasta] [output.fasta]
```

[cnt.py](https://github.com/hzz0024/BioinfoTools#data-analysis) [python] : track down the number of sequence started with "EEEE" (or something else"). 
```
USAGE
  $ python cnt.py --input [FILE]
```

[fasta_split.pl](https://github.com/hzz0024/BioinfoTools/blob/master/Perl_script/fasta_split.pl) [perl] : takes an input file in fasta format and splits it into a number of fasta files.
```
USAGE
  $ perl fasta_split.pl InputFastaFile NumFile
```

## Plotting

[Map_make.R](https://github.com/hzz0024/BioinfoTools/blob/master/R_script/Map_make.R) : map the population locations on a map.

[easyparallel_plot.R](https://github.com/hzz0024/BioinfoTools/blob/master/R_script/easyparallel_plot.R) : make scatter plot for parallel time
