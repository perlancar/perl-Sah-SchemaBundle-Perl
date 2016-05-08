package Sah::Schema::perl::distname;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl distribution name',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(-[A-Za-z_0-9]+)*\z',
}, {}];

1;
# ABSTRACT:
