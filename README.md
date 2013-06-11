csvTo301
=======

Introduction
--------------
A nice simple little perl helper script that parses a CSV file with two colums - The current url and the redirect url - and spits out a text file with a block of formatted mod_alias 301 redirect statements.  Handy if you're working on migrating a site with a large number of urls, but the architecture prevents implementing a DB solution and the only alternative is a block of statements in the .htaccess file!

collect the existing relative url e.g. /aboutus.htm and the relative destination link e.g. /about

**Note: ** the mod_alias module will ignore 301 redirects that have a querystring appended to the url that is being redirected e.g. *http://www.baseurl.com/news?article=12*.  For urls with this structure mod_rewrite  will have to be used to redirect i.e. links produced by this script won't be effective!

**Note 2: ** v0.1 doesn't sort the output

Requirements
-----------------
perl (obviously!)

Text::CSV cpan module (type "cpan Text::CSV" into terminal window to install)

Usage
--------
 perl csvto301.pl "**/path/to/csvfile.csv**" "**/path/for/output.txt**" "**http(s)://baseurl of destination**"
 
	perl csvto301.pl "data.csv" "output.txt" "http://www.website.com"
 
 Example of output to output.txt
 ------------------------------------
 
 Redirect 301 /home.htm http://baseurl/home
 Redirect 301 /aboutus.htm http://baseurl/about