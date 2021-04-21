# Postgres

## Example 1

```bash
docker compose up -d --build
docker compose down --remove-orphans
```

Alter table by adding a column with `NULL` as default value.

```bash
PGPASSWORD=example psql -h localhost -p 5432 -U postgres postgres
psql (13.2, server 11.11 (Debian 11.11-1.pgdg90+1))
Type "help" for help.

postgres=# \timing
Timing is on.

postgres=# ALTER TABLE child_table ADD COLUMN foo int DEFAULT NULL;
ALTER TABLE
Time: 4.489 ms

postgres=# ALTER TABLE child_table DROP COLUMN foo;
ALTER TABLE
Time: 3.349 ms
```

Now try the same with a foreign key constraint.

```bash
PGPASSWORD=example psql -h localhost -p 5432 -U postgres postgres
psql (13.2, server 11.11 (Debian 11.11-1.pgdg90+1))
Type "help" for help.

postgres=# \timing
Timing is on.

postgres=# ALTER TABLE child_table ADD COLUMN foo int DEFAULT NULL REFERENCES parent_table (id);
ALTER TABLE
Time: 133.122 ms

postgres=# ALTER TABLE child_table DROP COLUMN foo;
ALTER TABLE
Time: 6.256 ms
```

Finally, we defer the validation of the constraint.

```bash
PGPASSWORD=example psql -h localhost -p 5432 -U postgres postgres
psql (13.2, server 11.11 (Debian 11.11-1.pgdg90+1))
Type "help" for help.

postgres=# \timing
Timing is on.

postgres=# ALTER TABLE child_table ADD COLUMN foo int DEFAULT NULL;
ALTER TABLE
Time: 4.489 ms

postgres=# ALTER TABLE child_table ADD CONSTRAINT distfk FOREIGN KEY (foo) REFERENCES parent_table (id) NOT VALID;
ALTER TABLE
Time: 5.224 ms

postgres=# ALTER TABLE child_table VALIDATE CONSTRAINT distfk;
ALTER TABLE
Time: 104.855 ms

postgres=# ALTER TABLE child_table DROP COLUMN foo;
ALTER TABLE
Time: 6.256 ms
```

We can see that the validation of the foreign key constraint takes most of the time and by applying `NOT VALID` we can defer it.
