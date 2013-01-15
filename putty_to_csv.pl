#!/usr/bin/perl
#use strict;

#get the input file
print "Type in putty file: ";
my $infile = <STDIN>;
chomp($infile);
open(INFILE, "<$infile") or die "file open error";

#read the entire file into an array (I know, I know...)
my @dictionary = <INFILE>;
print "Number of lines: ",scalar @dictionary, "\n";

#the the output csv file
print "Type in outfile: ";
my $outfile = <STDIN>;
chomp($outfile);
if ($outfile eq "") {die;}
open(OUTFILE, ">$outfile");

#There are 32 batteries (0,31) 0 and 31 are not batteries, but are measures of the rail voltage
my @battvolts = (0) x 32;
my $index = 0;

#read through each line in the file
foreach my $word (@dictionary) 
{
	chomp($word);
	#regex find the data and populate the array holding the contents of one line of the csv file
	if($word =~ /V\[([0-3][0-9])\]=(\d+)/) {print $1," ",$2,"\n";$battvolts[$1] = $2/10000;}
	
	#write the array to the output file whenever the program sees battery index 31
	if($1 == 31)
	{
		print OUTFILE $index;
		foreach my $volt (@battvolts)
		{
			print OUTFILE ",$volt";
		}
		print OUTFILE "\n";
		$index = $index +1;
	}
}

#compute the timing unit
print "type in duration of test in minutes: ";
my $duration = <STDIN>;
print $duration*60/$index, " seconds in one time unit"; 
close OUTFILE;
<STDIN>;