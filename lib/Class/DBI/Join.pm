package Class::DBI::Join;

use strict;
use vars qw($VERSION @ISA);

$VERSION = 0.03;
use base 'Class::Data::Inheritable';
use mixin::with 'Class::DBI';


=head1 NAME

Class::DBI::Join - many-to-many relationships for Class::DBI

=head1 SYNOPSIS

  package Roles;
  use base  'Class::DBI';
  use mixin 'Class::DBI::Join';

  Roles->set_db('Main', 'dbi:whatever', 
                             'username', 'password');

  # Given a join table like:
  # CREATE TABLE films_and_actors (
  #     film_id     INTEGER     REFERENCES films,
  #     actor_id    INTEGER     REFERENCES actors
  # );
  # And assuming Film and Actor are Class::DBI subclasses.
  Roles->table('films_and_actors');

  Roles->hasa(Film  => 'film_id');
  Roles->hasa(Actor => 'actor_id');


  ...meanwhile...

  use Film;
  use Roles;

  my $btaste = Film->retrieve('Bad Taste');
  my @roles  = Roles->join($btaste);

=head1 DESCRIPTION

This is a representation of a join table using Class::DBI.  It allows
Class::DBI objects to properly express many-to-many relationships.

Class::DBI::Join is a mixin module.  For all intents and purposes,
it's a subclass of Class::DBI.  See L<mixin> for details.

Class::DBI::Join adds the following methods:

=head2 Class Methods

=over 4

=item I<join>

  my @roles = Roles->join($btaste);

=cut

__PACKAGE__->set_sql('ManyToMany', <<SQL);
SELECT  %s
FROM    %s AS join_tbl
WHERE   %s = ?
SQL

sub join {
    my($class, $one) = @_;

    my $hasa_cols    = __hasa_cols($class);
    return $class->search( $hasa_cols->{ref $one} => $one->id );
}


__PACKAGE__->mk_classdata('__hasa_cols');
__PACKAGE__->__hasa_cols({});

sub hasa {
    my($class, $hasa_class, $hasa_col) = @_;

    my $hasa_cols = __hasa_cols($class);
    $hasa_cols->{$hasa_class} = $hasa_col;

    return $class->SUPER::hasa($hasa_class, $hasa_col);
}


=back

=head1 AUTHOR

Michael G Schwern <schwern@pobox.com>


=head1 SEE ALSO

L<Class::DBI>, L<mixin>

=cut

1;
