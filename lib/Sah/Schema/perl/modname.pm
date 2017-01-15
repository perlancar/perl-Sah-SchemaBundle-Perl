package Sah::Schema::perl::modname;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl module name',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*\z',
    'x.perl.coerce_rules' => [
        'str_normalize_perl_modname',
    ],

    # provide a default completion which is from list of installed perl modules
    'x.completion' => 'perl_modname',

}, {}];

1;
# ABSTRACT:
