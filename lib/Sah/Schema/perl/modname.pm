package Sah::Schema::perl::modname;

# AUTHORITY
# DATE
# DIST
# VERSION

use Regexp::Pattern::Perl::Module ();

our $schema = [str => {
    summary => 'Perl module name, e.g. Foo::Bar',
    description => <<'_',

This is a schema you can use when you want to accept a Perl module name. It
offers basic checking of syntax as well as a couple of conveniences. First, it
offers completion from list of locally installed Perl modules. Second, it
contains coercion rule so you can also input `Foo-Bar`, `Foo/Bar`, `Foo/Bar.pm`
or even 'Foo.Bar' and it will be normalized into `Foo::Bar`.

Note that this schema does not check that the Perl module exists or installed
locally. To check that, use the `perl::modname::installed` schema. And there's
also a `perl::modname::not_installed` schema.

_
    match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname}{pat} . ')\\z',

    'prefilters' => [
        'Perl::normalize_perl_modname',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.completion' => 'perl_modname',

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo::Bar', valid=>1},
        {value=>'Foo-Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo/Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo/Bar.pm', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo.Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo|Bar', valid=>0},
    ],

}, {}];

1;
# ABSTRACT:
