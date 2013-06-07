csvTo301
=======

Introduction
--------------
A nice simple little perl script that parses a CSV file with two colums - The current url and the redirect url - and spits out a text file with a block of formatted 301 redirect statements.  Handy if you're working on migrating a site with a large number of urls, but the architecture prevents implementing a DB solution and the only alternative is a block of statements in the .htaccess file!

collect the existing relative url e.g. /aboutus.htm and the relative destination link e.g. /about


Requirements
-----------------
perl (obviously!)
Text::CSV cpan module (type "cpan Text::CSV" into terminal window to install)

Usage
--------
 perl csvto301.pl "/path/to/csvfile.csv" "/path/for/output.txt" "http(s)://baseurl of destination"
 
 e.g. perl csvto301.pl "data.csv" "output.txt" "http://www.website.com"