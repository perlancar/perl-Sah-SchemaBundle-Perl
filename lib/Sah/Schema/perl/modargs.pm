package Sah::Schema::perl::modargs;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl module name with optional arguments',
    description => <<'_',

Perl module name with optional arguments which will be used as import arguments,
just like the `-MMODULE=ARGS` shortcut that `perl` provides. Examples:

    Foo
    Foo::Bar
    Foo::Bar=arg1,arg2

See also: `perl::modname`.

_
    match => '\A[A-Za-z_][A-Za-z_0-9]*(::[A-Za-z_0-9]+)*\z(?:=.*)?',

    #'x.perl.coerce_rules' => [
    #    'str_normalize_perl_modname',
    #],

    # XXX also provide completion for arguments
    'x.completion' => 'perl_modname',

}, {}];

1;
# ABSTRACT:
