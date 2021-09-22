### This pipeline is used to call SNPs using freebayes. The original code is from the dDocent. Three steps in this pipeline; first is to split the bed file into N parts.

### Step 1. Split the bed file into N parts (e.g., N = 60 below)

```bash
split -n l/60 --additional-suffix=.bed -d mapped.bed mapped.
```

### Step 2. Create bam file using each split bed coordinates

```bash
#!/bin/bash
for i in {00..59}; do
	samtools view -@$15 -b -1 -L mapped.$i.bed -o split.$i.bam filter.merged.bam
	samtools index split.$i.bam
done
```

### Step 3. Index the bam file

```bash
for i in {00..59}; do
    samtools index 'split.'$i'.bam'
done
```

### Step 4. Calling SNPs using freebayes

```bash
#!/bin/bash
start=`date +%s` # this part allows to report the time that used for each freebayes running
/programs/freebayes-v1.3.1/freebayes -b split.00.bam -t mapped.00.bed -v raw.00.vcf -f reference.fasta -m 5 -q 5 -E 3 --min-repeat-entropy 1 -n 10

end=`date +%s` ## date at end
runtime=$((end-start))
hours=$((runtime / 3600))
minutes=$(( (runtime % 3600) / 60 ))
seconds=$(( (runtime % 3600) % 60 ))
echo "Runtime: $hours:$minutes:$seconds (hh:mm:ss)"
```

Note: you can use the command below to write the 60 bash script in few seconds,

### write up the freebayes scripts, create a folder named "00_freebayes_script" before running the command below.

```bash
#!/bin/bash
for i in {00..59}
do
    echo -e '#!/bin/bash\nstart=`date +%s`\n/programs/freebayes-v1.3.1/freebayes -b split.'$i'.bam -t mapped.'$i'.bed -v raw.'$i'.vcf -f reference.fasta -m 5 -q 5 -E 3 --min-repeat-entropy 1 -n 10\n\nend=`date +%s` ## date at end\nruntime=$((end-start))\nhours=$((runtime / 3600))\nminutes=$(( (runtime % 3600) / 60 ))\nseconds=$(( (runtime % 3600) % 60 ))\necho "Runtime: $hours:$minutes:$seconds (hh:mm:ss)"' >> 00_freebayes_script/'formal_dDocent_freebayes'$i'.sh'
done
```

### write up the Slurm job submission command for each freebayes script

```bash
#!/bin/bash
for i in {00..59}
do
    echo -e '#!/bin/bash\nsbatch --job-name=fb_'$i' --output=./log/fb_'$i'.log --nodes=1 --ntasks=1 --mem=25000 formal_dDocent_freebayes'$i'.sh' >> 00_freebayes_script/'run_formal_dDocent_freebayes'$i'.sh'
done
```