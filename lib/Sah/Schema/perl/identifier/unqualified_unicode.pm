package Sah::Schema::perl::identifier::unqualified_unicode;

use strict;
use utf8;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Unqualified identifier in Perl, with "use utf8" in effect',
    description => <<'_',

_
    match => qr/\A
                (?[ ( \p{Word} & \p{XID_Start} ) + [_] ])
                (?[ ( \p{Word} & \p{XID_Continue} ) ])*
                \z/x,

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
        {value=>'bébé', valid=>1},
    ],

}];

1;
# ABSTRACT:

=head1 append:SEE ALSO

L<perldata>
