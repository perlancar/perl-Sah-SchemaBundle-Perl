package Sah::Schema::perl::modnames;

# DATE
# VERSION

our $schema = [array => {
    summary => 'Perl module names',
    description => <<'_',

Array of Perl module names, where each element is of `perl::modname` schema,
e.g. `Foo`, `Foo::Bar`.

Contains coercion rule that expands wildcard, so you can specify:

    Module::P*

and it will be expanded to e.g.:

    ["Module::Patch", "Module::Path", "Module::Pluggable"]

The wildcard syntax supports jokers (`?`, `*`, `**`), brackets (`[abc]`), and
braces (`{one,two}`).

_
    of => ["perl::modname", {req=>1}, {}],

    'x.perl.coerce_rules' => [
        'str_or_array_expand_perl_modname_wildcard',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.element_completion' => 'perl_modname',

}, {}];

1;
# ABSTRACT:
