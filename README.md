#Perl Freshdesk API Wrapper

This is very much a work-in-progress. Pull requests welcomed.

##API endpoints covered so far

* Add a note to a ticket
* Resolve a ticket

##Examples
```
use Freshdesk::Host;
use Freshdesk::Ticket;
...
my $host = new Freshdesk::Host($domain, $api_key);
my $ticket = new Freshdesk::Ticket($host, $ticket_number);
$ticket->add_note($note);
$ticket->resolve;
```
