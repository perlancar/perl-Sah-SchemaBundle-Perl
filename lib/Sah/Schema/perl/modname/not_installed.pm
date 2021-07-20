package Sah::Schema::perl::modname::not_installed;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = ['perl::modname' => {
    summary => 'Name of a Perl module that is not installed locally',
    description => <<'_',

This schema is based on the `perl::modname` schema with an additional check that
the perl module is not installed locally. Checking is done using
<pm:Module::Installed::Tiny>. This check fetches the source code of the module
from filesystem or %INC hooks, but does not actually load/execute the code.

_

    'prefilters' => [
        'Perl::check_module_not_installed',
    ],

    examples => [
    ],

}];

1;
# ABSTRACT:
