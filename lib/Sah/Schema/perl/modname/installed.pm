package Sah::Schema::perl::modname::installed;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = ['perl::modname' => {
    summary => 'Name of a Perl module that is installed locally',
    description => <<'_',

This schema is based on the `perl::modname` schema with an additional check that
the perl module is installed locally. Checking is done using
<pm:Module::Installed::Tiny>. This check fetches the source code of the module
from filesystem or %INC hooks, but does not actually load/execute the code.

_

    'prefilters' => [
        'Perl::check_module_installed',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
