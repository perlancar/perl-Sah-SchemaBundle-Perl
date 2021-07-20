package Sah::Schema::perl::release::version;

# AUTHORITY
# DATE
# DIST
# VERSION

my %all_versions;

# from build version of Module::CoreList
our @build_releases;
# CODE: require Data::Dmp; require Module::Build; '@build_releases = (' . join(",", map {qq("$_")} keys %Module::CoreList::released) . ');';
$all_versions{"$_"} = 1 for @build_releases;

# from installed version of Module::CoreList
require Module::CoreList;
$all_versions{"$_"} = 1 for keys %Module::CoreList::released;

# in addition to the numified (which, unfortunately, collapses 5.010000 to
# 5.10), also provides the x.y.z representations
my @all_versions;
for (sort keys %all_versions) {
    my $major = sprintf "%.0f", $_;
    my $minor = sprintf "%.0f", ($_ - $major) * 1000;
    my $rev   = sprintf "%.0f", ($_ - $major - $minor/1000) * 1e6;
    my $xyz   = sprintf "%d.%d.%d", $major, $minor, $rev;
    #print "$_ -> $xyz\n";
    $all_versions{$xyz} = 1;
}

our $schema = [str => {
    summary => 'One of known released versions of perl (e.g. 5.010 or 5.10.0)',
    description => <<'_',

Use this schema if you want to accept one of the known released versions of
perl.

The list of releases of perl is retrieved from the installed core module
<pm:Module::CoreList> during runtime as well as the one used during build. One
of both those Module::CoreList instances might not be the latest, so this list
might not be up-to-date. To ensure that the list is complete, you will need to
keep your copy of Module::CoreList up-to-date.

The list of version numbers include numified version (which, unfortunately,
collapses trailing zeros, e.g. 5.010000 into 5.010) as well as the x.y.z version
(e.g. 5.10.0).

_
    in => [sort keys %all_versions],
}];

1;
# ABSTRACT:

=head1 SEE ALSO

C<perl::release::*> is namespace for schemas related to perl releases.
