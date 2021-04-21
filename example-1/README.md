# Postgres

## Example 1

```bash
docker compose up -d --build
docker compose down --remove-orphans
```

Alter table by adding a column with `NULL` as default value

```bash
# for Postgres 10
export PORT=5432
# for Postgres 11
export PORT=5433
```

_Postgres 10.16_

```bash
PGPASSWORD=example psql -h localhost -p $PORT -U postgres postgres
psql (13.2, server 10.16 (Debian 10.16-1.pgdg90+1))
Type "help" for help.

postgres=# \timing
Timing is on.

postgres=# ALTER TABLE orig_table ADD COLUMN foo TEXT DEFAULT NULL;
ALTER TABLE
Time: 8.175 ms

postgres=# ALTER TABLE orig_table DROP COLUMN foo;
ALTER TABLE
Time: 1016.343 ms (00:01.016)
```

_Postgres 11.11_

```bash
PGPASSWORD=example psql -h localhost -p $PORT -U postgres postgres
psql (13.2, server 11.11 (Debian 11.11-1.pgdg90+1))
Type "help" for help.

postgres=# \timing
Timing is on.

postgres=# ALTER TABLE orig_table ADD COLUMN foo TEXT DEFAULT NULL;
ALTER TABLE
Time: 8.848 ms

postgres=# ALTER TABLE orig_table DROP COLUMN foo;
ALTER TABLE
Time: 3.647 ms
```
