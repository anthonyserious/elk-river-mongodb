#!/usr/bin/perl

while ($line = <>) {
  next if $line =~ /^procs/;
  
  my @keys = ("r", "b", "swpd", "free", "buff", "cache", "si", "so", "bi", "bo", "in", "cs", "us", "sy", "id", "wa");
  my @a  = split (' ', $line);
  my @vals = ();
  foreach $k (@keys) {
    push (@vals, "\"$k\":\"".shift(@a)."\"");
  }
  print "{".join(", ", @vals)."}\n";
}



