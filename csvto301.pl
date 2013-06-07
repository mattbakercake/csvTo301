#!/usr/bin/perl
    use strict;
    use warnings;
    use Text::CSV;
	
	my $validArgs = checkArgs();
	my %redirects;
	
	if ($validArgs) {
		parseCSV();
		writeTxtFile();
	} else {
		print "\l\n Please supply arguements:  \l\n\l\n perl csvto301.pl \"path/to/file.csv\"  \"outputfile.txt\" \"http(s)://redirecturl\"\l\n";
	}
	
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
	
	sub parseCSV {
		my $file = $ARGV[0];
		my $csv = Text::CSV->new();
		my $count = 0;
		my @columns;

		open (CSV, "<", $file) or die " cannot open file \"$file\": $!";
		while (<CSV>) {
			if ($csv->parse($_)) {
				 @columns = $csv->fields();
				 $redirects{$columns[0] } = $columns[1];
				 $count++;
			} else {
				my $err = $csv->error_input;
					print "Failed to parse line: $err";
			}
		}
		close CSV;
		print "parsed $count lines in \"$file\"\l\n";
	}
	
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
    