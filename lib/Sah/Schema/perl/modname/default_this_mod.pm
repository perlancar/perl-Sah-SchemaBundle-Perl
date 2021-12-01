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

_

    'x.perl.default_value_rules' => [
        'Perl::this_mod',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
