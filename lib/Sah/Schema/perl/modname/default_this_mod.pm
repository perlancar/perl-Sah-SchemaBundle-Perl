package Sah::Schema::perl::modname::default_this_mod;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = ['perl::modname' => {
    summary => 'Perl module, defaults to "this module"',
    description => <<'_',

See <pm:App::ThisDist>'s `this_mod()` for more details on how "this module" is
determined. Note that `App::ThisDist` is not added as dependency automatically;
you will have to add it manually.

Note: be careful when using this schema for actions that are destructive to a
Perl module or that change some things, because a user can perform those actions
without giving an argument (e.g. a `delete-module` script). It is safer to use
this schema to perform a non=destructive action (e.g. `man-module`) and/or
operate in dry-run mode by default.

_

    'x.perl.default_value_rules' => [
        'Perl::this_mod',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
