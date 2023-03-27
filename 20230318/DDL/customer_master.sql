CREATE TABLE customer_master (
  my_number varchar(32) NOT NULL DEFAULT '',
  name varchar(255) DEFAULT NULL,
  hiragana varchar(255) DEFAULT NULL,
  rome varchar(255) DEFAULT NULL,
  age int(11) DEFAULT NULL,
  birthday date DEFAULT NULL,
  sex varchar(8) DEFAULT NULL,
  blood_type varchar(4) DEFAULT NULL,
  mail varchar(255) DEFAULT NULL,
  tel varchar(255) DEFAULT NULL,
  smart_phone varchar(255) DEFAULT NULL,
  postal_code varchar(255) DEFAULT NULL,
  address varchar(255) DEFAULT NULL,
  company varchar(255) DEFAULT NULL,
  credit varchar(255) DEFAULT NULL,
  limited_term varchar(10) DEFAULT NULL,
  PRIMARY KEY (my_number)
)