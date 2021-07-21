# BioinfoTools

The repository is a library of bioinformatics tools for data analyses and visualization.

## Table Of Content

  - [Data Analysis](#Data_Analysis)
  - [Plotting](#Plotting)

## Data Analysis

[getseq.pl](getseq.pl) [perl] : extract the target sequence based on a list of IDs. 
```
USAGE
  $ perl getseq.pl [list of IDs] [seq.fasta] [output.fasta]
```

[cnt.py](cnt.py) [python] : track down the number of sequence started with "EEEE" (or something else"). 
```
USAGE
  $ python cnt.py --input [FILE]
```

[fasta_split.pl](fasta_split.pl) [perl] : takes an input file in fasta format and splits it into a number of fasta files.
```
USAGE
  $ perl fasta_split.pl InputFastaFile NumFile
```

## Plotting

[Map_make.R](Map_make.R) : map the population locations on a map.

[easyparallel_plot.R](easyparallel_plot.R) : make scatter plot for parallel time
