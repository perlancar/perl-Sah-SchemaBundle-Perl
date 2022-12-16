package Sah::Schema::perl::identifier::unqualified_ascii;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Unqualified identifier in Perl, without "use utf8" in effect',
    description => <<'_',

_
    match => qr/\A[A-Za-z_][A-Za-z_0-9]{0,250}\z/,

    examples => [
        {value=>'', valid=>0, summary=>'Empty'},

        # ascii
        {value=>'foo', valid=>1},
        {value=>'_foo', valid=>1},
        {value=>'0foo', valid=>0, summary=>'Cannot start with a digit'},
        {value=>'foo0', valid=>1},
        {value=>'foo-bar', valid=>0, summary=>'Invalid character (dash)'},
        {value=>'foo::bar', valid=>0, summary=>'Qualified name not accepted'},
        {value=>'$foo', valid=>0, summary=>'Sigil not accepted'},

        # unicode
        {value=>'bébé', valid=>0, summary=>'Non-latin letter not accepted'},
    ],

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<perldata>
