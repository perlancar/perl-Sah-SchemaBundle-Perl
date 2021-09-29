package Sah::Schema::perl::pod_filename;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'A .pod filename, e.g. /path/Foo.pod',
    description => <<'_',

Use this schema if you want to accept a filesystem path containing Perl POD. The
value of this schema is in the convenience of CLI completion, as well as
coercion from POD name.

String containing filename of a Perl .pod file. For convenience, when value is
in the form of:

    Foo
    Foo.pod
    Foo::Bar
    Foo/Bar
    Foo/Bar.pod

and a matching .pod file is found in `@INC`, then it will be coerced (converted)
into the filesystem path of that .pod file, e.g.:

    /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pod

To prevent such coercion, you can use prefixing path, e.g.:

    ./Foo::Bar
    ../Foo/Bar
    /path/to/Foo/Bar

This schema comes with convenience completion too.

_
    'x.perl.coerce_rules' => [
        'From_str::convert_perl_pod_to_path',
    ],
    'x.completion' => sub {
        require Complete::File;
        require Complete::Module;
        require Complete::Util;

        my %args = @_;
        my $word = $args{word};

        my @answers;
        push @answers, Complete::File::complete_file(word => $word);
        if ($word =~ m!\A\w*((?:::|/)\w+)*\z!) {
            push @answers, Complete::Module::complete_module(
                word => $word, find_pod=>1, find_pm=>0, find_pmc=>0);
        }

        Complete::Util::combine_answers(@answers);
    },

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::filename>

L<Sah::Schema::perl::pod_or_pm_filename>

L<Sah::Schema::perl::pm_filename>
