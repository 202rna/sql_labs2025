<h1 name="content" align="center"><a href=""><img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/></a> MSSQL Вариант 6</h1>

<p align="center">
  <a href="#-lab1"><img alt="lab1" src="https://img.shields.io/badge/Lab1-blue"></a> 
  <a href="#-lab2"><img alt="lab2" src="https://img.shields.io/badge/Lab2-red"></a>
  <a href="#-lab3"><img alt="lab3" src="https://img.shields.io/badge/Lab3-green"></a>
  <a href="#-lab4"><img alt="lab4" src="https://img.shields.io/badge/Lab4-yellow"></a>
  <a href="#-lab5"><img alt="lab5" src="https://img.shields.io/badge/Lab5-gray"></a>
  <a href="#-lab6"><img alt="lab6" src="https://img.shields.io/badge/Lab6-orange"></a> 
  <a href="#-lab7"><img alt="lab7" src="https://img.shields.io/badge/Lab7-brown"></a>
  <a href="#-lab8"><img alt="lab8" src="https://img.shields.io/badge/Lab8-purple"></a>
  <a href="#-lab9"><img alt="lab9" src="https://img.shields.io/badge/Lab9-violet"></a> 
</p>

# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab1
[Назад](#content)
<h4 align="left">
  <a href="#client"></a>
Разработать ER-модель данной предметной области: выделить сущности, их атрибуты, связи между сущностями. 
Для каждой сущности указать ее имя, атрибут (или набор атрибутов), являющийся первичным ключом, список остальных атрибутов.
Для каждого атрибута указать его тип, ограничения, может ли он быть пустым, является ли он первичным ключом.
Для каждой связи между сущностями указать: 
- тип связи (1:1, 1:M, M:N)
- обязательность

ER-модель д.б. представлена в виде ER-диаграммы (картинка)

По имеющейся ER-модели создать реляционную модель данных и отобразить ее в виде списка сущностей с их атрибутами и типами атрибутов,  для атрибутов указать, явл. ли он первичным или внешним ключом 
</h4>
Предметная область:
Работа книжного магазина
Описание Предметной области (ВНИМАНИЕ: список сущностей и их атрибутов определен ПРИМЕРНО, окончательное кол-во сущностей и их атрибутов нужно определить, исходя из раздела «Реализовать»)

Книги: шифр книги, список авторов, название, жанр.
Тиражи книг: Дата поступления тиража книги, издательство, закупочная цена тиража, число поступивших экземпляров тиража, число еще не проданных экземпляров тиража, цена продажи.

Реализовать:
- Поиск книги по шифру, автору или названию;
- Определение самой продаваемой книги – с наибольшим количеством проданных экземпляров по всем тиражам;
- Определение самой непродаваемой книги;
- Определение чистой прибыли с каждого тиража заданной книги и по всем тиражам вместе;
- Определение убыточных тиражей (общая цена всех проданных книг этого тиража не превысила закупочную цену);
- Печать списка книг по нужной теме.

Примечание: тираж – количество экземпляров одной книги, выпущенной издательством в конкретный срок. Например, одна и та же книга м.б. выпущена разными издательствами и в разные даты – это будут разные тиражи.

## ER model:

![image](/sources/er_diag.png)

 ## Relation model:

![image](/sources/relation_model_diag.png)


# <img src="https://github.com/user-attachments/assets/e080adec-6af7-4bd2-b232-d43cb37024ac" width="20" height="20"/> Lab2
[Назад](#content)
<h4>
В соответствии с реляционной моделью данных, разработанной в Лаб.№1, создать реляционную БД на учебном сервере БД :
- создать таблицы, определить первичные ключи и иные ограничения
- определить связи между таблицами
- создать диаграмму
- заполнить все таблицы адекватной информацией (не меньше 10 записей в таблицах, наличие примеров для связей типа 1:M )
</h4>


__DATABASE: bookshop__

## SQLQuery_create_tables:

```tsql
USE bookshop;
CREATE TABLE [Автор] (
	id		INT Not Null PRIMARY KEY,
	[имя]	NVARCHAR(255) Not Null
);

CREATE TABLE [Жанр] (
	id			INT Not Null PRIMARY KEY,
	[название]	NVARCHAR(255) Not Null
);

CREATE TABLE [Тема] (
	id			INT Not Null PRIMARY KEY,
	[название]	NVARCHAR(255) Not Null
);

CREATE TABLE [Книга_образец] (
	id			INT Not Null PRIMARY KEY,
	[название]	NVARCHAR(255) Not Null
);

CREATE TABLE [Издательство] (
	id			INT Not Null PRIMARY KEY,
	[название]	NVARCHAR(255) Not Null,
	[телефон]	NVARCHAR(11),
	[адрес]		NVARCHAR(255)
);

CREATE TABLE [Покупатель] (
	id		INT Not Null PRIMARY KEY,
	[ФИО]	NVARCHAR(255) Not Null,
	[адрес] NVARCHAR(255)
);

CREATE TABLE [Заказ] (
	id				INT Not Null PRIMARY KEY,
	[статус]		INT Not Null DEFAULT(0),
	[дата]			DATE Not Null,
	[id_покупателя] INT,
	FOREIGN KEY ([id_покупателя]) REFERENCES [Покупатель]([id]) ON DELETE CASCADE,
	CHECK ([статус] > -1 AND [статус] < 3)
);

CREATE TABLE [Тираж_книги] (
	id					INT Not Null PRIMARY KEY,
	[дата_поступления]	DATE Not Null,
	[дата]				DATE Not Null,
	[цена_продажи]		DECIMAL Not Null,
	[число_экземпляров] INT Not Null,
	[закупочная_цена]	DECIMAL Not Null,
	[id_издательства]	INT Not Null,
	FOREIGN KEY ([id_издательства]) REFERENCES [Издательство]([id]) ON DELETE CASCADE,
	CHECK ([число_экземпляров] >= 0 and [закупочная_цена] >= 0 and [цена_продажи] >= 0)
);

CREATE TABLE [Книга_экземпляр] (
	[шифр]				INT Not Null PRIMARY KEY,
	[id_тиража_книги]	INT Not Null,
	[id_образца]		INT Not Null,
	[id_заказа]			INT Not Null,
	FOREIGN KEY ([id_тиража_книги]) REFERENCES [Тираж_книги]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([id_образца]) REFERENCES [Книга_образец]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([id_заказа]) REFERENCES [Заказ]([id]) ON DELETE CASCADE
);

CREATE TABLE [Книга_Автор] (
    [id_книги]	INT Not Null,
    [id_автора] INT Not Null,
	PRIMARY KEY ([id_автора], [id_книги]),
    FOREIGN KEY ([id_автора]) REFERENCES [Автор]([id]),
    FOREIGN KEY ([id_книги]) REFERENCES [Книга_образец]([id])
);

CREATE TABLE [Книга_Жанр] (
	[id_книги] INT Not Null,
	[id_жанра] INT Not Null,
	PRIMARY KEY ([id_книги], [id_жанра]),
	FOREIGN KEY ([id_книги]) REFERENCES [Книга_образец]([id]),
	FOREIGN KEY ([id_жанра]) REFERENCES [Жанр]([id])
);

CREATE TABLE [Книга_Тема] (
	[id_книги]	INT Not Null,
	[id_темы]	INT Not Null,
	PRIMARY KEY ([id_книги], [id_темы]),
	FOREIGN KEY ([id_книги]) REFERENCES [Книга_образец]([id]),
	FOREIGN KEY ([id_темы]) REFERENCES [Тема]([id])
);

```
## SQLQuery_insert_values:

```tsql
INSERT INTO [Автор] (id, имя) VALUES
(1, N'Лев Толстой'),
(2, N'Фёдор Достоевский'),
(3, N'Александр Пушкин'),
(4, N'Антон Чехов'),
(5, N'Михаил Булгаков'),
(6, N'Николай Гоголь'),
(7, N'Иван Тургенев'),
(8, N'Владимир Набоков'),
(9, N'Сергей Есенин'),
(10, N'Марина Цветаева');

INSERT INTO [Издательство] (id, название, телефон, адрес) VALUES
(1, N'АСТ', '74951234567', N'Москва, ул. Ленина, д.1'),
(2, N'Эксмо', '74959876543', N'Санкт-Петербург, Невский пр., д.10'),
(3, N'Питер', '78121234567', N'Санкт-Петербург, ул. Пушкина, д.5'),
(4, N'Просвещение', '74951230000', N'Москва, ул. Тверская, д.20'),
(5, N'Дрофа', '74951239999', N'Москва, ул. Арбат, д.15'),
(6, N'Альпина', '74951231111', N'Москва, ул. Садовая, д.7'),
(7, N'Вече', '74959870000', N'Санкт-Петербург, ул. Мира, д.3'),
(8, N'КомпасГид', '74951232222', N'Москва, ул. Новая, д.12'),
(9, N'Манн, Иванов и Фербер', '74951233333', N'Москва, ул. Большая, д.8'),
(10, N'Эксмо-Пресс', '74959874444', N'Санкт-Петербург, ул. Ломоносова, д.9');

INSERT INTO [Заказ] (id, статус, дата, id_покупателя) VALUES
(1, 0, '2024-01-10', 1),
(2, 1, '2024-01-15', 2),
(3, 2, '2024-01-20', 3),
(4, 0, '2024-02-01', 4),
(5, 1, '2024-02-05', 5),
(6, 2, '2024-02-10', 6),
(7, 0, '2024-02-15', 7),
(8, 1, '2024-02-20', 8),
(9, 2, '2024-02-25', 9),
(10, 0, '2024-03-01', 10);

INSERT INTO [Книга_Жанр] (id_книги, id_жанра) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 1),
(6, 6),
(7, 1),
(8, 4),
(9, 2),
(10, 2);

...
```

## Database Diagram <sub>_SQL Server Management Studio 21_</sub>

![image](/sources/ssms_diag.png)
