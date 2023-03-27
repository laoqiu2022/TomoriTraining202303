CREATE TABLE city (
  no int(11) NOT NULL,
  name varchar(4) DEFAULT NULL,
  chief varchar(10) DEFAULT NULL,
  monarch_no int(11) DEFAULT NULL,
  army_group varchar(10) DEFAULT NULL,
  max_soldiers int(11) DEFAULT 0,
  soldiers int(11) DEFAULT 0,
  money int(11) DEFAULT 0,
  food_stuff int(11) DEFAULT 0,
  PRIMARY KEY (no),
  FOREIGN KEY (monarch_no) REFERENCES political(no)
)