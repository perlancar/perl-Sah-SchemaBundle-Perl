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

_

    'x.perl.default_value_rules' => [
        'Perl::this_dist',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
