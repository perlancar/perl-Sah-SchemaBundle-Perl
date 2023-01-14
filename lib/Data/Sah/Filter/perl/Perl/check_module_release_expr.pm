package Data::Sah::Filter::perl::Perl::check_module_release_expr;

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
        summary => 'Check that module release expression is syntactically valid, using Module::Release::Select',
        might_fail => 1,
    };
}

sub filter {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{modules}{"Module::Release::Select"} //= 0;
    $res->{expr_filter} = join(
        "",
        "do { my \$tmp = $dt; if (defined Module::Release::Select::parse_releases_expr(\$tmp)) { [undef, \$tmp] } else { ['Invalid releases expression', \$tmp] } }",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$
