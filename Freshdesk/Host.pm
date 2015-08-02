package Freshdesk::Host;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/.";
use Freshdesk::Ticket;

sub new {
    my ($class, $site, $apikey) = @_;

    die "You must specify a site, e.g. mydomain.freshdesk.com\n" unless defined $site;
    die "You must specify an API key, e.g. 1234567890ABCDEF\n" unless defined $apikey;

    my $self = {
        site => $site,
        apikey => $apikey,
    };
    bless $self, $class;
    return $self;
}

sub get_uri {
    my $self = shift;
    my $api_endpoint = shift;

    die "You must provide an API endpoint, e.g. /helpdesk/tickets/123.json" unless $api_endpoint;

    return "https://$self->{site}$api_endpoint";
}

sub add_note_to_ticket {
    my $self = shift;
    my $note = shift;
    my $ticket_number = shift;

    my $ticket = new Freshdesk::Ticket($self, $ticket_number);
    $ticket->add_note($note);
}

1;
