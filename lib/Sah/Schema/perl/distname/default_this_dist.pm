package Sah::Schema::perl::distname::default_this_dist;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = ['perl::distname' => {
    summary => 'Perl distribution name, defaults to "this distribution"',
    description => <<'_',

See <pm:App::ThisDist>'s `this_dist()` for more details on how "this
distribution" is determined. Note that `App::ThisDist` is not added as
dependency automatically; you will have to add it manually.

Note: be careful when using this schema for actions that are destructive to a
Perl dist or that change some things, because a user can perform those actions
without giving an argument (e.g. a `delete-dist` script). It is safer to use
this schema to perform a non=destructive action (e.g. `ls-dist`) and/or
operate in dry-run mode by default.

_

    'x.perl.default_value_rules' => [
        'Perl::this_dist',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
