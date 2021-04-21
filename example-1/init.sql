-- create sample table
CREATE TABLE test (id SERIAL NOT NULL, data FLOAT DEFAULT random());

-- create indexes
CREATE INDEX test_data_index ON test(data);
CREATE INDEX test_id_index ON test(id);

-- insert 1 million rows
INSERT INTO test (id)
  SELECT nextval('test_id_seq')
    FROM generate_series(1, 1000000);
