#!/usr/bin/env perl
use 5.14.1;
use warnings;
use utf8;
use open qw/:std :utf8/;

use Twitter::API;

my $api = Twitter::API->new_with_traits(
    traits => [ qw/ApiMethods InflateObjects/ ],
    consumer_key        => $ENV{CONSUMER_KEY},
    consumer_secret     => $ENV{CONSUMER_SECRET},
    access_token        => $ENV{ACCESS_TOKEN},
    access_token_secret => $ENV{ACCESS_TOKEN_SECRET},
);

my ( $r, $c ) = $api->verify_credentials;
say sprintf '%s is authorized', $r->screen_name;
say sprintf 'Rate limit: %s, remaining: %s',
    $c->rate_limit, $c->rate_limit_remaining;
