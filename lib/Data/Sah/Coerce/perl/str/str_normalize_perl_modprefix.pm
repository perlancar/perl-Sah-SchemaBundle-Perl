package Data::Sah::Coerce::perl::str::str_normalize_perl_modprefix;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
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
        "do { my \$tmp = $dt; \$tmp =~ s!::?|/|\\.|-!::!g; \$tmp .= '::' if \$tmp =~ /\\A\\w+(::\\w+)*\\z/; \$tmp }",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::modprefix from str

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can normalize strings in the form of:

 Foo::Bar

 Foo:Bar
 Foo:Bar:

 Foo-Bar
 Foo-Bar-

 Foo/Bar
 Foo/Bar/

 Foo.Bar
 Foo.Bar.

into:

 Foo::Bar::
