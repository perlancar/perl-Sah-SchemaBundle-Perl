package Sah::Schema::perl::version;

# DATE
# VERSION

our $schema = [obj => {
    summary => 'Perl version object',
    isa => 'version',
    'x.perl.coerce_rules' => [
        'From_str::perl_version',
    ],
}, {}];

1;
# ABSTRACT:
