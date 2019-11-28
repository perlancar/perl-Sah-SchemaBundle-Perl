package Data::Sah::Coerce::perl::To_str::From_str::normalize_perl_modname;

# AUTHOR
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        summary => 'Coerce perl::modname from str',
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
        "do { my \$tmp = $dt; \$tmp = \$1 if \$tmp =~ m!\\A(\\w+(?:/\\w+)*)\.pm\\z!; \$tmp =~ s!::?|/|\\.|-!::!g; \$tmp }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can normalize strings in the form of:

 Foo:Bar
 Foo-Bar
 Foo/Bar.pm
 Foo/Bar
 Foo.Bar

into:

 Foo::Bar
