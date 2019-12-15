package Sah::Schema::perl::qualified_funcname;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl function name, qualified with a package name',
    description => <<'_',

Currently function name is restricted to this regex:

    \A[A-Za-z_][A-Za-z_0-9]*\z

and package name is restricted to this regex:

    [A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*

_
    match => '\A(?:[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*::)[A-Za-z_]([A-Za-z_0-9]+)*\z',

    # TODO: provide convenience by providing list of core function names etc
    #'x.completion' => 'perl_funcname',

}, {}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::funcname>

L<Sah::Schema::perl::unqualified_funcname>
