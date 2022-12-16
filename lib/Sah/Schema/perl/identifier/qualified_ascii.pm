package Sah::Schema::perl::identifier::qualified_ascii;

use strict;
use utf8;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Qualified identifier in Perl, without "use utf8" in effect',
    description => <<'_',

_
    match => qr/\A[A-Za-z_][A-Za-z_0-9]*(?:::[A-Za-z_0-9]+)+\z/,
    max_len => 251, # total max length, with qualifier and all the '::', but without the sigil

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
        {value=>'foo::bébé', valid=>0, summary=>'Non-latin letter not accepted'},
    ],

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<perldata>
