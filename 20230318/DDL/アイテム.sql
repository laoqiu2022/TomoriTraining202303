CREATE TABLE item (
  no int(11) NOT NULL,
  name varchar(20) DEFAULT NULL,
  type varchar(4) DEFAULT NULL,
  value int(11) DEFAULT NULL,
  owner varchar(10) DEFAULT NULL,
  city varchar(4) DEFAULT NULL,
  PRIMARY KEY (no)
)