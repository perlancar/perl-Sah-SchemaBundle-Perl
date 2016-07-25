package Data::Sah::Coerce::perl::obj::str_perl_version;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 2,
        enable_by_default => 0,
        might_die => 1,
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
        "version->parse($dt)",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::version from str

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION
