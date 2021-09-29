package Sah::Schema::perl::modnames;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [array => {
    summary => 'Array of Perl module names, e.g. ["Foo::Bar", "Baz"]',
    description => <<'_',

Array of Perl module names, where each element is of `perl::modname` schema,
e.g. `Foo`, `Foo::Bar`.

Contains coercion rule that expands wildcard, so you can specify:

    Module::P*

and it will be expanded to e.g.:

    ["Module::Patch", "Module::Path", "Module::Pluggable"]

The wildcard syntax supports jokers (`?`, `*`, `**`), brackets (`[abc]`), and
braces (`{one,two}`). See <pm:Module::List::Wildcard> for more details.

_
    of => ["perl::modname", {req=>1}, {}],

    'x.perl.coerce_rules' => [
        'From_str_or_array::expand_perl_modname_wildcard',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.element_completion' => 'perl_modname',

}];

1;
# ABSTRACT:
