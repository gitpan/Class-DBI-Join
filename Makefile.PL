# A template for Makefile.PL.
# - Set the $PACKAGE variable to the name of your module.
# - Set $LAST_API_CHANGE to reflect the last version you changed the API 
#   of your module.
# - Fill in your dependencies in PREREQ_PM
# Alternatively, you can say the hell with this and use h2xs.

use ExtUtils::MakeMaker;

$PACKAGE = 'Class::DBI::Join';
($PACKAGE_FILE = $PACKAGE) =~ s|::|/|g;
$LAST_API_CHANGE = 0.03;

eval "require $PACKAGE";

unless ($@) { # Make sure we did find the module.
    print <<"CHANGE_WARN" if ${$PACKAGE.'::VERSION'} < $LAST_API_CHANGE;

NOTE: There have been API changes between this version and any older
than version $LAST_API_CHANGE!  Please read the Changes file if you
are upgrading from a version older than $LAST_API_CHANGE.

CHANGE_WARN
}


warn <<"DELETION_WARN";
Class::DBI::Join has been deleted, there is no code in this distribution.
Class::DBI handles many-to-many relationships just fine, please use its 
"Mapping" feature instead.

If you wish to find the old Class::DBI::Join, it is available on BackPAN.
http://history.perl.org/backpan/

DELETION_WARN


WriteMakefile(
    NAME            => $PACKAGE,
    VERSION         => 0.06,
);
