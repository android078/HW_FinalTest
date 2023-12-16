use myfirstdb;
CREATE TABLE cats
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO cats (name, an_type, birthday, color, commands)
VALUES
	('Murzic', 'cat', '2009-01-25', 'gray', 'кис-кис, брысь'),
    ('Barsik', 'cat', '2015-02-23', 'red', 'кис-кис, брысь'),
    ('Ruzunija', 'cat', '2018-09-04', 'black', 'кис-кис, брысь');
    
    CREATE TABLE dogs
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO dogs (name, an_type, birthday, color, commands)
VALUES
	('Morty', 'dog', '2022-11-24', 'red-white', 'сидеть, лежать, апорт, голос'),
    ('Deizi', 'dog', '2020-04-18', 'braune', 'сидеть, лежать, апорт, голос'),
    ('Lars', 'dog', '2019-03-07', 'white', 'сидеть, лежать, апорт, голос');
    
    CREATE TABLE rats
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO rats (name, an_type, birthday, color, commands)
VALUES
	('Homa', 'rat', '2021-12-01', 'gray', ''),
    ('Lora', 'rat', '2020-01-19', 'white', ''),
    ('Tolstij', 'rat', '2023-07-21', 'black', '');
    
    CREATE TABLE horses
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO horses (name, an_type, birthday, color, commands)
VALUES
	('Bulat', 'horse', '2018-02-12', 'gray', 'шагом аллюр галоп'),
    ('Liza', 'horse', '2020-01-13', 'white', 'ко_мне шагом аллюр галоп'),
    ('Orlik', 'horse', '2022-03-01', 'black', 'шагом аллюр галоп');
    
    CREATE TABLE camels
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO camels (name, an_type, birthday, color, commands)
VALUES
	('Miha', 'camel', '2018-12-14', 'gray', 'лежать встать пошел'),
    ('Vasia', 'camel', '2021-09-25', 'white', 'лежать встать пошел'),
    ('Truck', 'camel', '2023-08-21', 'black', 'лежать встать пошел');
    
    CREATE TABLE donkeys
	(
		id INT AUTO_INCREMENT,
        an_type VARCHAR(10),
        name VARCHAR(20),
        birthday DATE,
        color VARCHAR(20),
        commands VARCHAR(50),
        PRIMARY KEY (id)
	);
    
    INSERT INTO donkeys (name, an_type, birthday, color, commands)
VALUES
	('Biba', 'donkey', '2019-12-17', 'gray', 'лежать встать пошел'),
    ('Boba', 'donkey', '2022-09-14', 'gray', 'лежать встать пошел'),
    ('Vizir', 'donkey', '2013-11-24', 'black', 'лежать встать пошел');
    
    -- объединяем таблицы cats, rats и dogs в таблицу pets
    
    CREATE TABLE pets
(
    id INT AUTO_INCREMENT,
    an_type VARCHAR(10),
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    PRIMARY KEY (id)
);

INSERT INTO pets (an_type, name, birthday, color, commands)
SELECT an_type, name, birthday, color, commands FROM cats
UNION
SELECT an_type, name, birthday, color, commands FROM dogs
UNION
SELECT an_type, name, birthday, color, commands FROM rats;

-- объединяем таблицы horses, camels и donkeys в таблицу pack_animals

CREATE TABLE pack_animals
(
    id INT AUTO_INCREMENT,
    an_type VARCHAR(10),
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    PRIMARY KEY (id)
);

INSERT INTO pack_animals (an_type, name, birthday, color, commands)
SELECT an_type, name, birthday, color, commands FROM horses
UNION
SELECT an_type, name, birthday, color, commands FROM camels
UNION
SELECT an_type, name, birthday, color, commands FROM donkeys;

-- удаляем верблюдов из таблицы вьючных животных
DELETE FROM pack_animals WHERE an_type = 'camel';

-- общая таблица для всех животных

CREATE TABLE animals
(
    id INT AUTO_INCREMENT,
    name VARCHAR(20),
    birthday DATE,
    color VARCHAR(20),
    commands VARCHAR(50),
    type VARCHAR(10),
    PRIMARY KEY (id)
);

INSERT INTO animals (name, birthday, color, commands, type)
SELECT name, birthday, color, commands, 'cats' FROM cats
UNION
SELECT name, birthday, color, commands, 'dogs' FROM dogs
UNION
SELECT name, birthday, color, commands, 'rats' FROM rats
UNION
SELECT name, birthday, color, commands, 'horses' FROM horses
UNION
SELECT name, birthday, color, commands, 'camels' FROM camels
UNION
SELECT name, birthday, color, commands, 'dokeys' FROM donkeys;

/* Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице
*/

CREATE TABLE young_animals
	(
		id INT AUTO_INCREMENT,
		name VARCHAR(20),
		birthday DATE,
		color VARCHAR(20),
		commands VARCHAR(50),
		type VARCHAR(10),
		age DECIMAL,
		PRIMARY KEY (id)
    );
    
    INSERT INTO young_animals (name, birthday, color, commands, type, age)
SELECT name, birthday, color, commands, 'cats', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM cats WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'dogs', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM dogs WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'rats', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM rats WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'horses', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM horses WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'camels', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM camels WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3)
UNION
SELECT name, birthday, color, commands, 'donkeys', TIMESTAMPDIFF(MONTH, birthday, CURDATE())
	FROM donkeys WHERE (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) > 1) AND (TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 3);
    
    


    
    
    