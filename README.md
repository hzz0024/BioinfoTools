# CBSU server and Slurm usage

## Table of Content

-   [Resources](#resources)
-   [Cluster structure](#cluster-structure)
    -   [Login nodes](#login-nodes)
    -   [Computing nodes](#computing-nodes)
        -   [General Info](#general-info)
        -   [Local storage on computing nodes](#local-storage-on-computing-nodes)
        -   [Scratch storage on computing nodes](#scratch-storage-on-computing-nodes)
    -   [Storage servers](#storage-servers)
    -   [Home directory](#home-directory)
-   [Cluster partitions](#cluster-partitions)
-   [Computing](#computing)
    -   [General rules](#general-rules)
    -   [Slurm submission options](#slurm-submission-options)
    -   [Job monitoring](#job-monitoring)
-   [A simple example of job submission using `sbatch`](#a-simple-example-of-job-submission-using-sbatch)
-   [Job arrays](#job-arrays)
    -   [Example - running SLiM jobs on the
        cluster](#example---running-slim-jobs-on-the-cluster)
-   [Accessing files from `cbsunt246` within a script or interactive session on the cluster](#accessing-files-from-cbsunt246-within-a-script-or-interactive-session-on-the-cluster)
-   [Q & A with Robert Bukowski](#q--a-with-robert-bukowski)


## Resources

-   [Therkildsen lab user-guide](https://github.com/therkildsen-lab/user-guide/blob/master/slurm_tutorial/slurm.md). Note some content in this post is sourced from here.    
-   [BSCB cluster guide](https://biohpc.cornell.edu/lab/cbsubscb_SLURM.htm)
-   [Slurm introduction by Princeton Research Computing](https://researchcomputing.princeton.edu/slurm)
-   [Introduction to slurm in the Bioinformatics Workbook](https://bioinformaticsworkbook.org/Appendix/Unix/01_slurm-basics.html#gsc.tab=0)
-   [Slurm overview](https://slurm.schedmd.com/overview.html)
-   [Slurm commands reference sheet](https://slurm.schedmd.com/pdfs/summary.pdf)
-   [Recordings of past BioHPC workshops](https://biohpc.cornell.edu/login_bio.aspx?ReturnURL=/lab/medialist.aspx)




---

# BioinfoTools

The part includes bioinformatics tools for data analyses and visualization.

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
