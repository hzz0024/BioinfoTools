#!/usr/bin/perl

use strict;

# to check the command line option
if($#ARGV<0){
    printf("Usage: \n <list> <seq> <outfile>\n");
    exit 1;
}

# to open the given infile file
open(gff, $ARGV[0]) or die "Cannot open the file $ARGV[0]";

open(seq, $ARGV[1]) or die "Cannot open the file $ARGV[1]";

# to open the file saving final result

open output, "> $ARGV[2]  " or die "Can't open file: $ARGV[2]";

my %seqhash = ();
my $id;
my $seq;
my $cds;

my $i = 0;

print "Processing cds seq\n";
#check the marker file, key is bes clone id
while(<seq>){ 
    
    my @line = split; 
    if(index ($line[0], '>') >=0 ){
	if($i != 0){
		#print "$id\n$seq\n";
		$seqhash{$id} = $seq;
		$seq = "";

	}	
	$id = $line[0];
	
    }
    else{
	$seq = $seq . $line[0];
    }
   $i++;
 
}
print "Ending of Processing cds seq\n";

print "Processing gff\n";

while(<gff>){ 

    my @line = split; 

    $id = $line[0];
    $id = ">" . $id;
    $seq = $seqhash{$id};
    
    print output "$id\n$seq\n";
    #print output ">$id\n$seq\n";

   
}
print "Ending of Processing gff\n";




close(gff);
close(seq);
close(output);

