-- create tables
CREATE TABLE parent_table (
  id SERIAL PRIMARY KEY NOT NULL,
  data FLOAT DEFAULT random()
);

CREATE TABLE child_table (
  id SERIAL PRIMARY KEY NOT NULL,
  data FLOAT DEFAULT random()
);

-- insert 10k rows in parent table
INSERT INTO parent_table (id)
  SELECT nextval('parent_table_id_seq')
    FROM generate_series(1, 10000);

-- insert 1m rows in child table
INSERT INTO child_table (id)
  SELECT nextval('child_table_id_seq')
    FROM generate_series(1, 1000000);
