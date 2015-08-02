package Freshdesk::Ticket;

use strict;
use warnings;
use parent 'Exporter';
our @EXPORT_OK = qw/add_note resolve/;
use HTTP::Request;
use LWP::UserAgent;

sub new {
    my $class = shift;
    my $host = shift;

    die "You must specify a Freshdesk Host object\n" unless defined $host;
    # if @_ contains another item...
    my $id = shift;

    my $self = {
        host => $host,
        id => $id,
    };
    bless $self, $class;
    return $self;
}

sub add_note {
    my $self = shift;
    my $note = shift;

    $self->die_unless_valid_ticket;

    my $api_endpoint = "/helpdesk/tickets/$self->{id}/conversations/note.json";
    my $uri = $self->{host}->get_uri($api_endpoint);
    my $request = HTTP::Request->new(POST => $uri);
    $request->header('content-type' => 'application/json');
    $request->authorization_basic($self->{host}->{apikey}, 'dummypassword');
    my $content = qq{{"helpdesk_note": {"body":"$note", "private":true}}};
    $request->content($content);
    my $ua = LWP::UserAgent->new;
    my $response = $ua->request($request);
    #print $response->content;
}

sub resolve {
    my $self = shift;

    $self->die_unless_valid_ticket;

    my $api_endpoint = "/helpdesk/tickets/$self->{id}.json";
    my $uri = $self->{host}->get_uri($api_endpoint);
    my $request = HTTP::Request->new(PUT => $uri);
    $request->header('content-type' => 'application/json');
    $request->authorization_basic($self->{host}->{apikey}, 'dummypassword');
    my $content = qq{{"helpdesk_ticket": {"status":4}}};
    $request->content($content);
    my $ua = LWP::UserAgent->new;
    my $response = $ua->request($request);
}

sub die_unless_valid_ticket {
    my $self = shift;
    die "This ticket ($self->{id}) has not been initialized.\n" unless $self->is_valid_ticket;
}

# Valid ticket IDs should be positive integers
sub is_valid_ticket {
    my $self = shift;
    return $self->{id} =~ /^[1-9][0-9]*$/;
}

1;
