package Film;

use base qw(MyBase);
use strict;

#Film->db_Main->do('DROP TABLE IF EXISTS Movies');
Film->db_Main->do(<<'SQL');
  CREATE TABLE Movies (
      title         VARCHAR(80)
  )
SQL

Film->table('Movies');
Film->columns('All' => qw(title));

END { Film->db_Main->do('DROP TABLE Movies') }
