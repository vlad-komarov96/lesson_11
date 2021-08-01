--Практическое задание по теме “Оптимизация запросов”
--Создайте таблицу logs типа Archive. 
--Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи,
--название таблицы, идентификатор первичного ключа и содержимое поля name.


DROP DATABASE IF EXISTS office;
CREATE DATABASE office;
USE office;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL DEFAULT NOW(),
	table_name VARCHAR(25) NOT NULL,
	id_table INT UNSIGNED NOT NULL,
	name_value VARCHAR(100)
) ENGINE=ARCHIVE;


CREATE TRIGGER users_log AFTER INSERT ON users FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'users',
      id_table = NEW.id,
      name_value = NEW.name;

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'catalogs',
      id_table = NEW.id,
      name_value = NEW.name;

CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'products',
      id_table = NEW.id,
      name_value = NEW.name;

--Практическое задание по теме “NoSQL”
--1)В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

--В коллекцию ip добавляю ip-адреса

SADD ip '127.0.0.1' '125.0.0.4' '122.0.0.4' '120.0.0.7'

--Для получения всех элементов использую

SMEMBERS ip


--2)При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
--поиск электронного адреса пользователя по его имени.


set vlad-komarov-96@mail.ru vlad
set vlad vlad-komarov-96@mail.ru 

get vlad-komarov-96@mail.ru 
get vlad

--3)Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB. 

db.shop.insert({category: 'books'})
db.shop.insert({category: 'magazines'})

db.shop.update({category: 'books'}, {$set: { name:['Great Gatsby', '1984', 'Anna Karenina'] }})
db.shop.update({category: 'magazines'}, {$set: { name:['Cosmopolitan', 'National Geographic', 'TIME '] }})

