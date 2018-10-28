require_relative '../automated_init'


snapshot_class = EntitySnapshot::Postgres::ReadOnly
store = Controls::EntityStore.example(snapshot_class: snapshot_class)
