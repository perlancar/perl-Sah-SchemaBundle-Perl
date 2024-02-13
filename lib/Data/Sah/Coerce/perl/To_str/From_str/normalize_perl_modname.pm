package Data::Sah::Coerce::perl::To_str::From_str::normalize_perl_modname;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

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

    $res->{expr_match} = "!ref($dt)";
    $res->{expr_coerce} = join(
        "",
        "do { my \$tmp = $dt;",
        "  my \$argssuffix = ''; \$argssuffix = \$1 if \$tmp =~ s/(=.*)\\z//;",                                  # extract args suffix (=arg1,arg2) first
        "  my \$versuffix = ''; \$versuffix = \$1 if \$tmp =~ s/(\@[0-9][0-9A-Za-z]*(\\.[0-9A-Za-z_]+)*)\\z//;", # extract version suffix part first
        "  \$tmp = \$1 if \$tmp =~ m!\\A(\\w+(?:/\\w+)*)\.pm\\z!;",
        "  \$tmp =~ s!::*|/+|\\.+|-!::!g;",
        "  \$tmp . \$versuffix . \$argssuffix",
        "}",
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
