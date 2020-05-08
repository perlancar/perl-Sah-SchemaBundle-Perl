package Sah::Schema::perl::modprefixes;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [array => {
    summary => 'Perl module prefixes, e.g. ["", "Foo::", "Foo::Bar::"]',
    description => <<'_',

Array of Perl module prefixes, where each element is of `perl::modprefix`
schema, e.g. `Foo::`, `Foo::Bar::`.

Contains coercion rule that expands wildcard, so you can specify:

    Module::C*

and it will be expanded to e.g.:

    ["Module::CPANTS::", "Module::CPANfile::", "Module::CheckVersion::", "Module::CoreList::"]

The wildcard syntax supports jokers (`?`, '*`) and brackets (`[abc]`). See the
`unix` type of wildcard in <pm:Regexp::Wildcards>, which this coercion rule
uses.

_
    of => ["perl::modprefix", {req=>1}, {}],

    'x.perl.coerce_rules' => [
        'From_str_or_array::expand_perl_modprefix_wildcard',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.element_completion' => 'perl_modprefix',

}, {}];

1;
# ABSTRACT:
