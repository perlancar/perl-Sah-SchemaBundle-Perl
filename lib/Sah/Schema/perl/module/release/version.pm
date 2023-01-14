package Sah::Schema::perl::module::release::version;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Expression to select module release',
    prefilters => ['Perl::check_module_release_expr'],
    examples => [
        {value=>'', valid=>0},
        {value=>'0.001', valid=>1},
        {value=>'< latest', valid=>1},
        {value=>'< foo', valid=>0},
    ],
}];

1;
# ABSTRACT:

=head1 SEE ALSO
