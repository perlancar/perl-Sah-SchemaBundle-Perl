package Sah::Schema::perl::modname_pm;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

use Regexp::Pattern::Perl::Module ();

our $schema = [str => {
    summary => 'Perl module name in Foo/Bar.pm form',
    description => <<'_',

This is just like the `perl::modname` schema except that instead of to
`Foo::Bar`, it normalizes to `Foo/Bar.pm`.

_
    match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname_pm}{pat} . ')\\z',

    'prefilters' => [
        'Perl::normalize_perl_modname_pm',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.completion' => 'perl_modname',

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo::Bar', valid=>1, validated_value=>'Foo/Bar.pm'},
        {value=>'Foo-Bar', valid=>1, validated_value=>'Foo/Bar.pm'},
        {value=>'Foo/Bar', valid=>1, validated_value=>'Foo/Bar.pm'},
        {value=>'Foo/Bar.pm', valid=>1},
        {value=>'Foo.Bar', valid=>1, validated_value=>'Foo/Bar.pm'},
        {value=>'Foo|Bar', valid=>0},
    ],

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::modname>
