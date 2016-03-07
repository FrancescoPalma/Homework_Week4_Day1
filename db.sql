CREATE TABLE shops (
  id serial8 primary key,
  name varchar(255),
  address varchar(255),
  stock_type varchar(255)
);

CREATE TABLE animals (
  id serial8 primary key,
  shop_id int8 references shops(id),
  name varchar(255),
  species varchar(255),
  image_url varchar(255)
);