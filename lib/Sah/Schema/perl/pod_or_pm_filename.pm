package Sah::Schema::perl::pod_or_pm_filename;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [str => {
    summary => 'A .pod or .pm filename, e.g. /path/Foo.pm or /path/Bar/Baz.pod',
    description => <<'_',

String containing filename of a Perl POD or module. For convenience, when value
is in the form of:

    Foo
    Foo.pod
    Foo.pm
    Foo::Bar
    Foo/Bar
    Foo/Bar.pod
    Foo/Bar.pm

and a matching .pod or .pm file is found in `@INC`, then it will be coerced
(converted) into the path of that .pod/.pm file, e.g.:

    /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pm
    lib/Foo/Bar.pod

To prevent such coercion, you can use prefixing path, e.g.:

    ./Foo::Bar
    ../Foo/Bar
    /path/to/Foo/Bar

This schema comes with convenience completion too.

This schema is like another schema `perl::filename` except that .pod is
prioritized over .pm. If both `Foo.pm` and `Foo.pod` are found in `@INC`, the
path to `Foo.pod` will be returned.

_
    'x.perl.coerce_rules' => [
        'From_str::convert_perl_pod_or_pm_to_path',
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
            push @answers, Complete::Module::complete_module(word => $word);
        }

        Complete::Util::combine_answers(@answers);
    },

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::perl::filename>

L<Sah::Schema::perl::pod_filename>

L<Sah::Schema::perl::pm_filename>
