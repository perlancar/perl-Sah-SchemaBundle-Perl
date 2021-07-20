package Sah::Schema::perl::modname_with_optional_ver;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl module name (e.g. Foo::Bar) with optional version number suffix (e.g. Foo::Bar@0.001)',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*(@[0-9][0-9A-Za-z]*(\\.[0-9A-Za-z_]+)*)?\z',
    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname',
    ],

    # provide a default completion which is from list of installed perl distributions
    'x.completion' => 'perl_modname',

    examples => [
        {value=>'', valid=>0},
        {value=>'Foo-Bar', valid=>1, validated_value=>'Foo::Bar'},
        {value=>'Foo::Bar', valid=>1},
        {value=>'Foo-Bar@1.0.0', valid=>1, validated_value=>'Foo::Bar@1.0.0'},
        {value=>'Foo::Bar@1.0.0', valid=>1},
        {value=>'Foo-Bar@0.5_001', valid=>1, validated_value=>'Foo::Bar@0.5_001'},
        {value=>'Foo::Bar@0.5_001', valid=>1},
        {value=>'Foo::Bar@a', valid=>0},
    ],

}];

1;
# ABSTRACT:
