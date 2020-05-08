package Sah::Schema::perl::unqualified_funcname;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'Perl function name which must not be qualified with a package name, e.g. subname',
    description => <<'_',

Currently function name is restricted to this regex:

    \A[A-Za-z_][A-Za-z_0-9]*\z

This schema includes syntax validity check only; it does not check whether the
function actually exists.

This schema includes syntax validity check only; it does not check whether the
function actually exists.

_
    match => '\A[A-Za-z_]([A-Za-z_0-9]+)*\z',

    # TODO: provide convenience by providing list of core function names etc
    #'x.completion' => 'perl_funcname',

}, {}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::funcname>

L<Sah::Schema::perl::qualified_funcname>
