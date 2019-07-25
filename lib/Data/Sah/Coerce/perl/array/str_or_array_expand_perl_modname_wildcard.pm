package Data::Sah::Coerce::perl::array::str_or_array_expand_perl_modname_wildcard;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

sub meta {
    +{
        v => 4,
        prio => 50,
    };
}

sub coerce {
    my %args = @_;

    my $dt = $args{data_term};

    my $res = {};

    $res->{expr_match} = "ref($dt) eq '' || ref($dt) eq 'ARRAY'";
    $res->{modules}{"PERLANCAR::Module::List"} //= 0;
    $res->{modules}{"Regexp::Wildcards"} //= 0;
    $res->{modules}{"String::Wildcard::Bash"} //= 0;
    $res->{expr_coerce} = join(
        "",
        "do { ",
        "my \$tmp = $dt; \$tmp = [\$tmp] unless ref \$tmp eq 'ARRAY'; ",
        "my \$i = 0; ",
        "while (\$i < \@\$tmp) { ",
        "  my \$el = \$tmp->[\$i++]; ",
        "  next unless String::Wildcard::Bash::contains_wildcard(\$el); ",
        "  my \$re = Regexp::Wildcards->new(type=>'unix')->convert(\$el); ",
        "  if (!\$main::_sah_coerce_modlist) { \$main::_sah_coerce_modlist = PERLANCAR::Module::List::list_modules('', {recurse=>1, list_modules=>1}) } ", # currently not very efficient? should've used prefix in wildcard, e.g. Foo::* should then search only under Foo::
        "  my \@exp_result; ",
        "  for (sort keys %\$main::_sah_coerce_modlist) { push \@exp_result, \$_ if \$_ =~ \$re } ",
        "  if (\@exp_result) { splice \@\$tmp, \$i-1, 1, \@exp_result; \$i += \@exp_result-1 } ",
        "} ", # while
        "\$tmp ",
        "}", # do
    );

    $res;
}

1;
# ABSTRACT: Expand wildcard of Perl module names

=for Pod::Coverage ^(meta|coerce)$

=head1 DESCRIPTION

This rule can expand wildcard of Perl module names in string (or string elements
in array) into array. Example:

 "Module::P*"
 ["Foo", "Module::P*", "Bar"]

will become, respectively:

 ["Module::Patch", "Module::Path", "Module::Pluggable"]
 ["Foo", "Module::Patch", "Module::Path", "Module::Pluggable", "Bar"]

when a string does not contain wildcard pattern, or if a pattern fails to match
any module name, it will be left unchanged, e.g.:

 ["Foo", "Fizz*", "Bar"]

will become, respectively:

 ["Foo", "Fizz*", "Bar"]
