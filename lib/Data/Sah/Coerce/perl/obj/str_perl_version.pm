package Data::Sah::Coerce::perl::obj::str_perl_version;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        might_fail => 1,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "!ref($dt)";
    $res->{expr_coerce} = join(
        "",
        "do { my \$v; eval { \$v = version->parse($dt) }; if (\$@) { ['Invalid version format'] } else { [undef, \$v] } }",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::version from str

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION
