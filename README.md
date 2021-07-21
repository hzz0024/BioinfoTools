# CBSU server and Slurm usage for Hare Lab

## Table of Content

-   [Resources](#resources)
-   [Cluster structure](#cluster-structure)
    -   [Login nodes](#login-nodes)
    -   [Computing nodes](#computing-nodes)
        -   [General Info](#general-info)
        -   [Local storage on server](#local-storage-on-server)
        -   [Computing space on server](#computing-space)
-   [Computing](#computing)
    -   [General rules](#general-rules)
    -   [Slurm submission options](#slurm-submission-options)
    -   [Job monitoring](#job-monitoring)
-   [A simple example of job submission using `sbatch`](#a-simple-example-of-job-submission-using-sbatch)
-   [Q & A with Robert Bukowski](#q--a-with-robert-bukowski)


## Resources

-   [Therkildsen lab user-guide](https://github.com/therkildsen-lab/user-guide/blob/master/slurm_tutorial/slurm.md). Note some contents in this post is borrowed from here.    
-   [BSCB cluster guide](https://biohpc.cornell.edu/lab/cbsubscb_SLURM.htm)
-   [Slurm introduction by Princeton Research Computing](https://researchcomputing.princeton.edu/slurm)
-   [Introduction to slurm in the Bioinformatics Workbook](https://bioinformaticsworkbook.org/Appendix/Unix/01_slurm-basics.html#gsc.tab=0)
-   [Slurm overview](https://slurm.schedmd.com/overview.html)
-   [Slurm commands reference sheet](https://slurm.schedmd.com/pdfs/summary.pdf)
-   [Recordings of past BioHPC workshops](https://biohpc.cornell.edu/login_bio.aspx?ReturnURL=/lab/medialist.aspx)

## Cluster structure

![](https://github.com/hzz0024/BioinfoTools/blob/master/example/Slide1.jpeg)

<br>

#### Login nodes

-   Use `ssh` to connect to login nodes (Cornell VPN is needed).
    -   It has have the domain name `cbsuhare.biohpc.cornell.edu`.
    -   E.g. `ssh netid@cbsuhare.biohpc.cornell.edu`

![](https://github.com/hzz0024/BioinfoTools/blob/master/example/login.jpeg)

<br>

#### Computing nodes

###### General Info

-   `cbsuhare` is owned by Hare lab but managed by the BioHPC team. The server is a part of BioHPC Cloud and share all the software available in BioHPC. It equips with 48 cores, 256 GB RAM, and 144 TB disk space (theoretically but some system files may eat up the space).
-   The server can be accessed directly though `ssh`
-   You can either run jobs directly on the server or use a job scheduler (SLURM).
-   Unlike the login nodes, accessing the `cbsuhare` server requires Cornell network connect (i.e. VPN if you are off campus).

###### Local storage on server

-   `cbsuhare` server has a local permanent storage, with a capcity of 144 TB.
-   The local storage is located at the directory `/local/storage`. 
-   Create your storage folder with netID (e.g. hz269) 
-   The local storage can be mounted to any other node using the command (not done yet)
    `/programs/bin/labutils/mount_server node_name /storage`.
    -   e.g. `/programs/bin/labutils/mount_server cbsubscb16 /storage`  
-   The mounted storage then becomes available under the directory `/fs/node_name/storage/`  
-   After mounting step your input files can be accessed from any of the computing nodes (not done yet).

###### Computing space on server

-   They are located under `/workdir/`.  
-   It is recommended to copy your input files from storage space to this scratch storage for computing.  
-   The scratch storage is shared by all users, but unlike reversed node (CBSU hourly paid servers), it is not necessary to copy back the output files to storage space. 

## Computing

#### General rules

-   Be aware of CPU, RAM, disk, and timing needs of your jobs. Please do not run heavy tasks directly on the server.
    -   Instead, write everything in a script that you submit using `sbatch` (i.e. Slurm scheduler).
-   Determining optimal values for job submission comes with experience, and it is usually best to submit test jobs to get an estimate for the number of processors, usage of memory, and wall time.

#### Slurm submission options

Various options can be specified to control the various aspects of computing on a Slurm cluster. There are two ways to do this:

**1. By appending the options after `sbatch` on command line (recommand).**

For example,

``` bash
sbatch --job-name=somename --nodes=1 --ntasks=6 --mem=4000 submit.sh
```

**2. Through `#SBATCH` headers at the beginning of the shell script.**

The following example contains the most useful headers. You will need to
delete the text within parentheses if you want to use this as a
template.

``` bash
#!/bin/bash -l                   (change the default shell to bash; '-l' ensures your .bashrc will be sourced in, thus setting the login environment)
#SBATCH --nodes=1                (number of nodes, i.e., machines; all non-MPI jobs *must* run on a single node, i.e., '--nodes=1' must be given here)
#SBATCH --ntasks=8               (number of tasks; by default, 1 task=1 slot=1 thread)
#SBATCH --mem=8000               (request 8 GB of memory for this job; default is 1GB per job; here: 8)
#SBATCH --time=1-20:00:00        (wall-time limit for job; here: 1 day and 20 hours)
#SBATCH --job-name=jobname             (change name of job)
#SBATCH --output=jobname.out.%j  (write stdout+stderr to this file; %j willbe replaced by job ID)
#SBATCH --mail-user=email@address.com          (set your email address)
#SBATCH --mail-type=ALL          (send email at job start, end or crash - do not use if this is going to generate thousands of e-mails!)
```

When the script is ready, you can save it as `submit.sh`, for example, and submit it with `sbatch submit.sh`.

#### Job monitoring

-   `sinfo` : report the overall state of the cluster and queues
-   `scontrol show nodes` : report detailed information about the
    cluster nodes, including current usage
-   `scontrol show partitions` : report detailed information about the
    queues (partitions)
-   `squeue` : show jobs running and waiting in queues
-   `squeue -u abc123` : show jobs belonging to user abc123
-   `scancel 1564` : cancel job with jobID 1564. All processes
    associated with the job will be killed

## A simple example of job submission using `sbatch`

`simple_example.sh` merges 365 fasta files into 1.

``` bash
cat simple_example.sh
```

    ## #!/bin/bash -l
    ## #SBATCH --time=10:00
    ## #SBATCH --partition=short
    ## #SBATCH --job-name=simple_job
    ## #SBATCH --output=simple_job.out
    ## 
    ## # Create working directory
    ## WORKDIR=/workdir/$USER/$SLURM_JOB_ID
    ## mkdir -p $WORKDIR
    ## cd $WORKDIR
    ## 
    ## # Copy files to working directory
    ## cp /home/ikk23/example/fastas/*.* $WORKDIR
    ## cp /home/ikk23/example/prefix_list.txt $WORKDIR
    ## 
    ## # Merge files
    ## COMPILED_FASTA=compiled_sequences.fasta
    ## touch $COMPILED_FASTA
    ## 
    ## for PREFIX in `cat prefix_list.txt`; do
    ##   cat $PREFIX'_consensus.fa' >> $COMPILED_FASTA
    ## done
    ## 
    ## # Transfer back to home directory
    ## cp $COMPILED_FASTA /home/ikk23/example/results/
    ## 
    ## # Clean up working directory
    ## rm -rf $WORKDIR

Job headers:

-   `#SBATCH --time=10:00` : set a time limit of 10 minutes
-   `#SBATCH --partition=short` : use the **short** queue, since this
    job will take less than 4 hours
-   `#SBATCH --job-name=simple_job` : this is the name that will appear
    in `squeue`
-   `#SBATCH --output=simple_job.out` : direct error messsages to this
    file, which will be placed in the working directory from which you
    submitted the job

Submit this job with: `sbatch simple_example.sh`

-   You can include job headers here instead. For example, I could have
    omitted the headers above and instead done
    `sbatch simple_example.sh -t 10:00 -p short -J simple_job -o simple_job.out`
-   Once you submit your job, you’ll get a message that includes the job
    number
    -   ex: `Submitted batch job 1844784`

You can view the status of your jobs with: `squeue -u netid` or `squeue`

-   If you’d rather be notified via email at the job start, end, or
    crash, include headers `#SBATCH --mail-user=email@address.com` and
    `#SBATCH --mail-type=ALL`

Kill your job with: `scancel jobnumber`

## Q & A with Robert Bukowski

1.  How do you suggest figuring out the time and memory requirements for
    SLURM scripts?

-   It’s mostly trial and error, as stated in the guide.
-   Most programs state how their memory requirements scale with the
    size of the data in the user manual.
-   There’s currently no BioHPC database on job requirements

2.  What’s your advice on backing up files?

-   If you can’t generate the data within a week of computation, back it
    up.
-   Always keep 2 copies.

3. Other information?

-   Some applications, such as `x11` and `Docker deamon`, are tricky and
    operate outside of SLURM
-   The number of nodes has to be specified (with `-N 1`). There is no
    default. Make sure to specify every time.
-   If your job isn’t running, do some debugging on your own before
    contacting them.

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
