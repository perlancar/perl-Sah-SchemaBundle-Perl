package Sah::Schema::perl::modname_with_optional_args;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

use Regexp::Pattern::Perl::Module ();

our @examples_str = (
    {value=>'', valid=>0},
    {value=>'Foo::Bar', valid=>1},
    {value=>'Foo::Bar=arg1,arg2', valid=>1},
    {value=>'Foo-Bar=arg1,arg2', valid=>1, validated_value=>'Foo::Bar=arg1,arg2'},
    #{value=>'Foo::Bar=arg1,arg2 foo', valid=>0}, # XXX why fail?
);

our @examples_array = (
    {value=>[], valid=>0, summary=>"No module name"},
    {value=>["Foo"], valid=>1},
    {value=>["Foo Bar"], valid=>0, summary=>"Invalid module name"},
    {value=>["Foo","arg"], valid=>0, summary=>"Args must be arrayref or hashref"},
    {value=>["Foo",{arg1=>1, arg2=>2}], valid=>1},
    {value=>["Foo",["arg1","arg2"]], valid=>1},
    {value=>["Foo",["arg1","arg2"],{}], valid=>0, summary=>"Too many elements"},
);

our $schema_str = [str => {
    summary => 'Perl module name (e.g. Foo::Bar) with optional arguments (e.g. Foo::Bar=arg1,arg2)',
    description => <<'_',

Perl module name with optional arguments which will be used as import arguments,
just like the `-MMODULE=ARGS` shortcut that `perl` provides. Examples:

    Foo
    Foo::Bar
    Foo::Bar=arg1,arg2

See also: `perl::modname`.

_
    match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname_with_optional_args}{pat} . ')\\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname',
    ],

    # XXX also provide completion for arguments
    'x.completion' => 'perl_modname',

    examples => \@examples_str,
}];

our $schema_array = [array_from_json => {
    summary => 'A 1- or 2-element array containing Perl module name (e.g. ["Foo::Bar"]) with optional arguments (e.g. ["Foo::Bar", ["arg1","arg2"]])',
    description => <<'_',

These are valid values for this schema:

    ["Foo"]                                      # just the module name
    ["Foo::Bar", ["arg1","arg2"]]                # with import arguments (array)
    ["Foo::Bar", {"arg1"=>"val","arg2"=>"val"}]  # with import arguments (hash)

_
    min_len => 1,
    max_len => 2,
    elems => [
        ["perl::modname",{req=>1}],
        ["any", {
            req=>1,
            of=>[
                ["array",{req=>1}],
                ["hash",{req=>1}]],
        }],
    ],
    examples => \@examples_array,
}];

our $schema = [any => {
    summary => 'Perl module name (e.g. Foo::Bar) with optional arguments (e.g. Foo::Bar=arg1,arg2)',
    description => <<'_',

Perl module name with optional arguments which will be used as import arguments,
just like the `-MMODULE=ARGS` shortcut that `perl` provides. Examples:

    Foo
    Foo::Bar
    Foo::Bar=arg1,arg2

See also: `perl::modname`.
A two-element array from (coercible from JSON string) is also allowed:

    ["Foo::Bar", \@args]

_
    of => [
        $schema_array,
        $schema_str,
    ],

    # XXX also provide completion for arguments
    'x.completion' => 'perl_modname',

    examples => [
        @examples_str,
        @examples_array,
    ],
}];

1;
# ABSTRACT:
