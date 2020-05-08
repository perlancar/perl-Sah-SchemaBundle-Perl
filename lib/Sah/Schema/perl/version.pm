package Sah::Schema::perl::version;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [obj => {
    summary => 'Perl version object',
    description => <<'_',

Use this schema if you want to accept a version object (see <pm:version>).
Coercion from string is provided.

_
    isa => 'version',
    'x.perl.coerce_rules' => [
        'From_str::perl_version',
    ],
}, {}];

1;
# ABSTRACT:
