package Data::Sah::Coerce::perl::str::str_convert_perl_pm_or_pod_to_path;

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

    $res->{modules}{'Module::Path::More'} //= 0;
    $res->{expr_match} = "1";
    $res->{expr_coerce} = join(
        "",
        "do { ",
        "my \$tmp = $dt; ",
        "if (\$tmp =~ m!\\A\\w+((?:/|::)\\w+)*(?:\\.pm|\\.pod)?\\z!) {",
        "  \$tmp =~ s!/!::!g; \$tmp =~ s/\\.(pm|pod)\\z//;",
        "  Module::Path::More::module_path(module=>\$tmp) || \$tmp ",
        "} else {",
        "  \$tmp ",
        "} ",
        "}",
    );

    $res;
}

1;
# ABSTRACT: Coerce perl::modname from str

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
