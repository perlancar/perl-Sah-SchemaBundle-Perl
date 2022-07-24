package Sah::Schema::perl::distname;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl distribution name, e.g. Foo-Bar',
    match => '\A[A-Za-z_][A-Za-z_0-9]*(-[A-Za-z_0-9]+)*\z',
    'x.perl.coerce_rules' => [
        'From_str::normalize_perl_distname',
    ],

    # provide a default completion which is from list of installed perl distributions
    'x.completion' => 'perl_distname',

    description => <<'_',

This is a schema you can use when you want to accept a Perl distribution name,
e.g. `WWW-Mechanize`. It offers basic checking of syntax as well as a couple of
conveniences. First, it offers completion from list of locally installed Perl
distribution. Second, it contains coercion rule so you can also input
`Foo::Bar`, `Foo/Bar`, `Foo/Bar.pm`, or even 'Foo.Bar' and it will be normalized
into `Foo-Bar`.

To see this schema in action on the CLI, you can try e.g. the `dist-has-deb`
script from <pm:App::DistUtils> and activate its tab completion (see its manpage
for more details). Then on the CLI try typing:

    % dist-has-deb WWW-<tab>
    % dist-has-deb dzp/<tab>

Note that this schema does not check that the Perl disribution exists on CPAN or
is installed locally. To check that, use the `perl::distname::installed` schema.
And there's also a `perl::distname::not_installed` schema.

_
}];

1;
# ABSTRACT:
