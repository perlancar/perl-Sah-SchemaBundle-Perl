package Sah::Schema::perl::pm_filename;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Filename (.pm file)',
    description => <<'_',

String containing filename of a Perl module. For convenience, when value is in
the form of:

    Foo
    Foo.pm
    Foo::Bar
    Foo/Bar
    Foo/Bar.pm

and a matching .pm file is found in `@INC`, then it will be coerced (converted)
into the path of that .pm file, e.g.:

    /home/ujang/perl5/perlbrew/perls/perl-5.24.0/lib/site_perl/5.24.0/Foo/Bar.pm

To prevent such coercion, you can use prefixing path, e.g.:

    ./Foo::Bar
    ../Foo/Bar
    /path/to/Foo/Bar

This schema comes with convenience completion too.

_
    'x.perl.coerce_rules' => [
        'From_str::convert_perl_pm_to_path',
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
                word => $word, find_pod=>0);
        }

        Complete::Util::combine_answers(@answers);
    },

}, {}];

1;
# ABSTRACT:
