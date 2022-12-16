package Sah::Schema::perl::identifier::qualified_unicode;

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
                (?:
                    ::(?[ ( \p{Word} & \p{XID_Continue} ) + [_] ])+
                )+
                \z/x,

    examples => [
        {value=>'', valid=>0, summary=>'Empty'},

        # ascii
        {value=>'foo', valid=>0, summary=>'Not qualified'},
        {value=>'foo::bar', valid=>1},
        {value=>"foo'bar", valid=>0, summary=>"This schema does not accept the old (soon-to-be-deprecated) namespace separator"},
        {value=>'_foo::bar', valid=>1},
        {value=>'0foo::bar', valid=>0, summary=>'Cannot start with a digit'},
        {value=>'foo::0', valid=>1, summary=>'Secondary+ parts are allowed to start with a digit (1)'},
        {value=>'foo::0bar', valid=>1, summary=>'Secondary+ parts are allowed to start with a digit (2)'},
        {value=>'foo0::bar', valid=>1},
        {value=>'foo::bar-baz', valid=>0, summary=>'Invalid character (dash)'},
        {value=>'$foo::bar', valid=>0, summary=>'Sigil not accepted'},

        # unicode
        {value=>'bébé::0foo', valid=>1},
    ],

}];

1;
# ABSTRACT:

=head1 append:SEE ALSO

L<perldata>
