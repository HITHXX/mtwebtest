sub tokenization
{
     my ($norm_text) = @_;
 
 # language-independent part:
    # $norm_text =~ s/<skipped>//g; # strip "skipped" tags
    # $norm_text =~ s/-\n//g; # strip end-of-line hyphenation and join lines
    # $norm_text =~ s/\n/ /g; # join lines
    # $norm_text =~ s/&quot;/"/g;  # convert SGML tag for quote to "
    # $norm_text =~ s/&amp;/&/g;   # convert SGML tag for ampersand to &
    # $norm_text =~ s/&lt;/</g;    # convert SGML tag for less-than to >
    # $norm_text =~ s/&gt;/>/g;    # convert SGML tag for greater-than to <

 # language-dependent part (assuming Western languages):
     $norm_text = " $norm_text ";
    #$norm_text =~ tr/[A-Z]/[a-z]/ unless $preserve_case;
     $norm_text =~ s/([\{-\~\[-\` -\&\(-\+\:-\@\/])/ $1 /g;   # tokenize punctuation
     $norm_text =~ s/([^0-9])([\.,])/$1 $2 /g; # tokenize period and comma unless preceded by a digit
     $norm_text =~ s/([\.,])([^0-9])/ $1 $2/g; # tokenize period and comma unless followed by a digit
     $norm_text =~ s/([0-9])(-)/$1 $2 /g; # tokenize dash when preceded by a digit
     $norm_text =~ s/\s+/ /g; # one space only between words
     $norm_text =~ s/^\s+//;  # no leading space
     $norm_text =~ s/\s+$//;  # no trailing space

     return $norm_text;
}

   open(FIN,$ARGV[0])||die("cannot open $ARGV[0]");
   open(FOUT,">$ARGV[1]");
   my($line);
   my($text);
   my($pre);
   my($end);
   while ($line = <FIN>){
   if ($line =~ m/<seg id/){
       $line =~ m/(<.*?>)(.*)(<\/seg>)/;
       $text = $2;
       $pre = $1;
       $end = $3;
       $text = tokenization($text);
       print FOUT $pre.$text.$end;
       print FOUT "\n";
   }
   else {
   print FOUT $line;}
   }
   close(FIN);
   close(FOUT);