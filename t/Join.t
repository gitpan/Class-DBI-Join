#!/usr/bin/perl -w

use Test::More tests => 11;
require_ok('Class::DBI::Join');

use lib qw(t/lib/);
require Film;
require Actor;
require Roles;

Film->create({ title => "Bad Taste" });
Film->create({ title => "Forgotten Silver" });
Film->create({ title => "Dead Alive" });
Film->create({ title => "Blowback" });

Actor->create({ name => "Peter Jackson" });
Actor->create({ name => "Sam Neil" });
Actor->create({ name => "Terry Potter" });
Actor->create({ name => "Craig Smith (I)" });

my %Films = (
    'Bad Taste' => 
             [{ actor => 'Peter Jackson', as_name => 'Derek' },
              { actor => 'Peter Jackson', as_name => 'Robert' },
              { actor => 'Terry Potter',  as_name => 'Ozzy', },
              { actor => 'Terry Potter',  as_name => '3rd Class Alien' },
              { actor => 'Craig Smith (I)', as_name => 'Giles' },
              { actor => 'Craig Smith (I)', as_name => '3rd Class Alien' },
             ],
    'Dead Alive' =>
             [{ actor => 'Peter Jackson', 
                as_name => "Undertaker's Assistant" }],
    'Forgotten Silver' => 
             [{ actor => 'Peter Jackson', as_name => 'Himself' },
              { actor => 'Sam Neil',      as_name => 'Himself' },
              ],
    'Blowback' => 
             [{ actor => 'Craig Smith (I)', as_name => 'Dr. Crack' }],
             
);

while( my($film_name, $roles) = each %Films ) {
    my $film = Film->retrieve($film_name) ||
               Film->create({ name => $film_name });

    foreach my $role (@$roles) {
        my($actor_name, $as) = @{$role}{qw(actor as_name)};
        my $actor = Actor->retrieve($actor_name) ||
                    Actor->create({ name => $actor_name });

        Roles->create({ film_id    => $film->id,
                             actor_id   => $actor->id,
                             as_name    => $as
                           });
    }
}


my $btaste = Film->retrieve('Bad Taste');
my @bt_roles = Roles->join($btaste);
is( @bt_roles, 6 );

my $pj = Actor->retrieve('Peter Jackson');
my @pj_roles = Roles->join($pj);
is( @pj_roles, 4 );

foreach my $role (@pj_roles) {
    isa_ok( $role->actor, 'Actor' );
    isa_ok( $role->film,  'Film'  );
}
