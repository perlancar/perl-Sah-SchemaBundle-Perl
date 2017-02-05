package Sah::Schema::perl::filename;

# DATE
# VERSION

our $schema = [str => {
    summary => 'Perl module name or file name',
    'x.perl.coerce_rules' => [
        'str_normalize_perl_modname_or_filename',
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

}, {}];

1;
# ABSTRACT:
