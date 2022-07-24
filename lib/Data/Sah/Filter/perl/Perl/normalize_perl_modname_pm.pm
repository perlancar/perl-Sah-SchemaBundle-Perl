package Data::Sah::Filter::perl::Perl::normalize_perl_modname_pm;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Normalize perl module name to Foo/Bar.pm form',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; ",
        "if (ref \$tmp) { [\"Must be a string and not a reference\", \$tmp] } ",
        "else { ", (
            "my \$argssuffix = ''; \$argssuffix = \$1 if \$tmp =~ s/(=.*)\\z//;",                                   # extract args suffix (=arg1,arg2) first
            "my \$versuffix = ''; \$versuffix = \$1 if \$tmp =~ s/(\@[0-9][0-9A-Za-z]*(\\.[0-9A-Za-z_]+)*)\\z//; ", # extract version suffix part first
            "\$tmp = \$1 if \$tmp =~ m!\\A(\\w+(?:/\\w+)*)\.pm\\z!; ",
            "\$tmp =~ s!::?|/|\\.|-!::!g; ",
            "\$tmp =~ s!::!/!g; ",
            "[undef, \"\$tmp.pm\" . \$versuffix . \$argssuffix]; "),
        "} }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 DESCRIPTION

This prefilter rule can normalize strings in the form of:

 Foo:Bar
 Foo-Bar
 Foo/Bar.pm
 Foo/Bar
 Foo.Bar

into:

 Foo/Bar.pm
