package Data::Sah::Filter::perl::Perl::check_module_not_installed;

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
        summary => 'Check that module is not installed locally',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{"Module::Installed::Tiny"} //= 0;
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; if (Module::Installed::Tiny::module_installed(\$tmp)) { [\"Module \$tmp is installed\", \$tmp] } else { [undef, \$tmp] } }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
