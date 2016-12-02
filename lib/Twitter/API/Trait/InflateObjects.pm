package Twitter::API::Trait::InflateObjects;
# ABSTRACT: Inflate hash refs, URLs, and timestamps to objects

use 5.14.1;
use Moo::Role;
use Hash::Objectify;
use Data::Visitor::Callback;
use Regexp::Common qw/URI time/;
use URI;
use Twitter::API::Util qw/timestamp_to_timepiece/;
use namespace::clean;

my $plain_values = sub {
    return unless defined;

    return URI->new($_) if /^$RE{URI}{HTTP}{-scheme => 'https?'}$/;

    # $RE{time} uses %Z (capital Z) only. The actual format is %z (+0000)
    # which %Z matches just fine, here.
    return timestamp_to_timepiece($_)
        if /^$RE{time}{strftime}{-pat => '%a %b %d %T %Z %Y'}$/;

    return $_;
};

has objectify_visitor => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        Data::Visitor::Callback->new(
            hash => sub { objectify $_ },
            plain_value => $plain_values,
        );
    },
    handles => { objectify_hashes => 'visit' },
);

around inflate_response => sub {
    my ( $next, $self, $c ) = @_;

    $self->$next($c);
    my $objectified = $self->objectify_hashes($c->result);
    $c->set_result($objectified);
};

1;
