package Roles;

use base  'MyBase';
use mixin 'Class::DBI::Join';

#Roles->db_Main->do('DROP TABLE IF EXISTS Films_and_Actors');
Roles->db_Main->do(<<'SQL');
  CREATE TABLE Films_and_Actors (
      film_id         VARCHAR(80),
      actor_id        VARCHAR(80),
      as_name         VARCHAR(80)
  )
SQL


Roles->table('Films_and_Actors');
Roles->columns( Essential => qw(film_id actor_id as_name) );
Roles->hasa(Film   => 'film_id');
Roles->hasa(Actor  => 'actor_id');
*film  = Roles->can('film_id');
*actor = Roles->can('actor_id');

END { Roles->db_Main->do('DROP TABLE Films_and_Actors') }
