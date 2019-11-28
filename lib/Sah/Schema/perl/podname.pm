package Sah::Schema::perl::podname;

# DATE
# VERSION

our $schema = ['str' => {
    summary => 'Perl POD name',
    description => <<'_',

Perl POD name, e.g. `Config`, `Some::Other::POD`.

Basically the same as `perl::modname`, but with a different completion.

_
    match => '\A[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*\z',

    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_modname',
    ],

    # provide a default completion which is from list of installed perl PODs
    'x.completion' => 'perl_modname',

}, {}];

1;
# ABSTRACT:
