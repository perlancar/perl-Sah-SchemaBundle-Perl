package Data::Sah::Coerce::perl::perl__distname::str;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 2,
        enable_by_default => 0,
        might_die => 0,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "1";
    $res->{expr_coerce} = join(
        "",
        "do { (my \$tmp = $dt) =~ s!::?|/|\\.!-!g; \$tmp }",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::distname from str

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can normalize strings in the form of:

 Foo::Bar
 Foo:Bar
 Foo/Bar
 Foo.Bar

into:

 Foo-Bar
