package Actor;

use base qw(MyBase);
use strict;

#Actor->db_Main->do('DROP TABLE IF EXISTS Actors');
Actor->db_Main->do(<<'SQL');
  CREATE TABLE Actors (
      name         VARCHAR(80)
  )
SQL

Actor->table('Actors');
Actor->columns('All' => qw(name));

END { Actor->db_Main->do('DROP TABLE Actors') }
