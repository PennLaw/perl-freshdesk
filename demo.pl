#!/usr/bin/perl -w

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/.";
use Freshdesk::Host;

print "Freshdesk API Demo\n";
print "------------------\n";

print "Enter Freshdesk host (e.g. mydomain.freshdesk.com): ";
my $hostname = <STDIN>;
chomp $hostname;
print "Enter your Freshdesk API key (e.g. 1234567890ABCDEF): ";
my $key = <STDIN>;
chomp $key;

my $freshdesk = new Freshdesk::Host($hostname,$key);
print "site: $freshdesk->{site}\n";
print "apikey: $freshdesk->{apikey}\n";

print "Add a private note to a ticket:\n";

print "Ticket number?\n";
my $t = <STDIN>;
chomp $t;
print "Note?\n";
my $n = <STDIN>;
chomp $n;

print "ticket: $t\nnote: $n\n";

#$freshdesk->add_note_to_ticket($n, $t);
my $ticket = new Freshdesk::Ticket($freshdesk, $t);
$ticket->add_note($n);

print "Resolve a ticket:\n";
print "Ticket number?\n";
$t = <STDIN>;
chomp $t;
$ticket = new Freshdesk::Ticket($freshdesk, $t);
$ticket->resolve;


