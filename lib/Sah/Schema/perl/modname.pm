package Sah::Schema::perl::modname;

# AUTHORITY
# DATE
# DIST
# VERSION

use Regexp::Pattern::Perl::Module ();

our $schema = [str => {
    summary => 'Perl module name, e.g. Foo::Bar',
    description => <<'_',

Contains coercion rule so you can also input `Foo-Bar`, `Foo/Bar`, `Foo/Bar.pm`
or even 'Foo.Bar' and it will be normalized into `Foo::Bar`.

_
    match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname}{pat} . ')\\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname',
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
