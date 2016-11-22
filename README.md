Twitter-API-Trait-InflateObjects
================================
A Trait for Twitter::API that inflates results to Perl objects.

Features
--------
* Recursively walks Twitter API results creating objects for each hash.
* Creates read/write accessors for each hash key.

Background
----------
This trait is provided in its own package because it has many dependencies not required by Twitter::API. Most users will not want this trait. It provides convenience, but at a high runtime cost. The extra dependencies are not needed by most users of Twitter::API.

Install
-------
```
dzil install
```

Usage
-----

Basic example:

```perl
use Twitter::API;

my $api = Twitter::API->new(
    traits => [ qw/ApiMethods InflateObjects/ ],
    %other_new_options,
);

my $r = $api->show_user('twitter');
say $r->location;
```

Output:
```
San Francisco, CA
```

Authors
-------
* [Marc Mims](https://github.com/semifor)
