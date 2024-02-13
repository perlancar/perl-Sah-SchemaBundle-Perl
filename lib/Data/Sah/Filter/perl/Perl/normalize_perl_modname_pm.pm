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
        examples => [
            {value=>"Foo:Bar", valid=>1, filtered_value=>"Foo/Bar.pm"},
            {value=>"Foo::Bar,arg1,arg2", valid=>1, filtered_value=>"Foo/Bar.pm=arg1,arg2"},
        ],
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
            "my \$argssuffix = ''; \$argssuffix = \$1 if \$tmp =~ s/([=,].*)\\z//; \$argssuffix =~ s/\\A,/=/; ",    # extract args suffix (=arg1,arg2) first. we allow % in addition to =
            "my \$versuffix = ''; \$versuffix = \$1 if \$tmp =~ s/(\@[0-9][0-9A-Za-z]*(\\.[0-9A-Za-z_]+)*)\\z//; ", # extract version suffix part first
            "\$tmp = \$1 if \$tmp =~ m!\\A(\\w+(?:/+\\w+)*)\.pm\\z!; ",
            "\$tmp =~ s!::*|/+|\\.+|-!::!g; ",
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

This rule can also handle version after module name, e.g.:

 Foo/Bar.pm@1.23

as well as optional import arguments like perl's C<-M>:

 Foo/Bar.pm=arg1,arg2
 Foo/Bar.pm@1.23=arg1,arg2

For convenience with bash completion (because C<=> is by default a word-breaking
character in bash, while C<,> is not) you can use C<,> instead of C<=> and it
will be normalized to C<=>.

 Foo/Bar.pm,arg1,arg2           # will become Foo/Bar.pm=arg1,arg2
 Foo/Bar.pm@1.23,arg1,arg2      # will become Foo/Bar.pm@1.23=arg1,arg2
