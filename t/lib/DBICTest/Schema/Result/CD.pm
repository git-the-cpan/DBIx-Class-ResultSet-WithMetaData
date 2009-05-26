package # hide from PAUSE 
    DBICTest::Schema::Result::CD;

use base 'DBIx::Class::Core';

__PACKAGE__->table('cd');
__PACKAGE__->add_columns(
  'cdid' => {
    data_type => 'integer',
    is_auto_increment => 1,
  },
  'artist' => {
    data_type => 'integer',
  },
  'title' => {
    data_type => 'varchar',
    size      => 100,
  },
  'year' => {
    data_type => 'varchar',
    size      => 100,
  },
);
__PACKAGE__->set_primary_key('cdid');
__PACKAGE__->add_unique_constraint([ qw/artist title/ ]);

__PACKAGE__->belongs_to( artist => 'DBICTest::Schema::Result::Artist' );

__PACKAGE__->has_many( tracks => 'DBICTest::Schema::Result::Track' );
__PACKAGE__->has_many(
    tags => 'DBICTest::Schema::Result::Tag', undef,
    { order_by => 'tag' },
);
__PACKAGE__->has_many(
    cd_to_producer => 'DBICTest::Schema::Result::CD_to_Producer' => 'cd'
);

__PACKAGE__->many_to_many( producers => cd_to_producer => 'producer' );
__PACKAGE__->many_to_many(
    producers_sorted => cd_to_producer => 'producer',
    { order_by => 'producer.name' },
);

1;
