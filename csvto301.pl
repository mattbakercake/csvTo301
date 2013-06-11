#!/usr/bin/perl

## v0.1
## 11/06/2013 dev@mikesierra.net

##
#	csvto301rewrite.pl parses 2 column csv and generates
#	txt file with formatted apache mod_rewrite 301 redirects
#	that can be pasted into .htaccess file
##
use strict;
use warnings;
use Text::CSV;

## globally accessible variables
my $validArgs = checkArgs(); #boolean
my %redirects; #hash containing redirects as $redirects{oldurl} = newurl

##
#	Code - constructor if you will!
##
if ($validArgs) {
	parseCSV();
	writeTxtFile();
} else {
	print "\l\n Please supply arguements:  \l\n\l\n perl csvto301.pl \"path/to/file.csv\"  \"outputfile.txt\" \"http(s)://redirecturl\"\l\n";
}
## End of code

##
#	checkArgs subroutine checks that the script has been
#	called with the correct number of aguements, and that 
#	the last one at least appears to be a url
#
#	returns: boolean
##
sub checkArgs {
	if (!defined $ARGV[0] || !defined $ARGV[1] || !defined $ARGV[2]) {
		return 0;
	} else {
		if ($ARGV[2] !~ /^http[s]?:\/\/[\w\/.]*/) {
			return 0;
			last;
		}
		return 1;
	}
}

##
#	parseCSV subroutine attempts to open specified csv file,
#	parse it spit values into @columns array
#	sets key=>value pair in  global %redirects hash
##
sub parseCSV {
	my $file = $ARGV[0];
	my $csv = Text::CSV->new();
	my $count = 0;
	my @columns;

	open (CSV, "<", $file) or die " cannot open file \"$file\": $!";
	while (<CSV>) { # for each line of csv
		if ($csv->parse($_)) { #call the parse function of Text::CSV
			 @columns = $csv->fields(); #add values to array
			 $redirects{$columns[0] } = $columns[1]; #add array values to global hash
			 $count++;
		} else {
			my $err = $csv->error_input;
				print "Failed to parse line: $err";
		}
	}
	close CSV;
	print "parsed $count lines in \"$file\"\l\n";
}

##
#	writeTxtFile subroutine creates a text file, loops through the
#	global %redirects hash and appends apache
#	mod_alias 301 redirect statements to it.  
## 
sub writeTxtFile {
	my $file = $ARGV[1];
	my $baseUrl = $ARGV[2];
	
	open (FILE, ">>", $file) or die " cannot open file \"$file\": $!";
	while (my ($key,$value) = each(%redirects)) {
		print FILE "Redirect 301 $key $baseUrl$value\l\n";
	}
	close(FILE);
	print "Redirect statements written to \"$file\"";
}
    