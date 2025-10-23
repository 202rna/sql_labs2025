USE bookshop;

SELECT 
	*
FROM
	[dbo].[Издательство]
ORDER BY
	[название] ASC, [телефон] DESC


SELECT
	*
FROM 
	[dbo].[Покупатель]
WHERE
	[ФИО] = 'Кузнецова Мария Ивановна'



SELECT
	*
FROM 
	[dbo].[Тираж_книги]
WHERE
	[дата_поступления] > '2024-01-01'



SELECT
	*
FROM
	[dbo].[Книга_Автор]

select * from [Автор]
select * from [Книга_образец]
insert into [Автор](id, имя) values 
(11, 'Наталья Олифер'),
(12, 'Виктор Олифер')

insert into [Книга_образец](id, название) values
(11, 'Компьютерные сети')

select * from [Книга_Автор]

insert into [Книга_Автор]([id_автора],[id_книги]) values 
(11,11), (12,11)

SELECT
	b.[название],
	COUNT([id_книги]) as 'Сколько авторов у книги'
FROM
	[dbo].[Книга_Автор] a
	INNER JOIN [dbo].[Книга_образец] b ON
		a.id_книги = b.id
GROUP BY
	[id_книги], b.[название]


SELECT
	MAX([число_экземпляров]) as 'Сколько максимально поступало в один день экземпляров'
FROM
	[dbo].[Тираж_книги]
GROUP BY
	[дата_поступления]


INSERT INTO [dbo].[Тираж_книги]([id],[id_издательства],[дата_поступления],[закупочная_цена],[цена_продажи],[число_экземпляров])
VALUES (11, 10, '2023-11-15', 600, 700, 1000)
SELECT * FROM [dbo].[Тираж_книги]

SELECT
	[статус], [дата],
	COUNT(*)
FROM
	[dbo].[Заказ]
GROUP BY CUBE([статус], [дата])

SELECT * FROM [dbo].[Покупатель]


SELECT
	[ФИО]
FROM
	[dbo].[Покупатель]
WHERE 
	[ФИО] NOT LIKE 'Иванов%'


SELECT
	ФИО, адрес, статус, дата
FROM
	[dbo].[Покупатель] c, [dbo].[Заказ] o
WHERE
	c.id = o.id_покупателя

SELECT
	название, телефон, адрес, дата_поступления, число_экземпляров,
	закупочная_цена
FROM
	[dbo].[Издательство] p, [dbo].[Тираж_книги] c
WHERE
	c.id_издательства = p.id


SELECT
	ФИО, адрес, статус, дата
FROM
	[dbo].[Покупатель] c
	INNER JOIN [dbo].[Заказ] o ON c.id = o.id_покупателя


SELECT
	название, телефон, адрес, дата_поступления, число_экземпляров,
	закупочная_цена
FROM
	[dbo].[Издательство] p
	INNER JOIN [dbo].[Тираж_книги] c ON c.id_издательства = p.id



SELECT * FROM [dbo].[Покупатель]

SELECT * FROM [dbo].[Заказ]

INSERT INTO [dbo].[Покупатель](id, [адрес], [ФИО]) VALUES
(11, 'Ярославль, Труфанова 24', 'Родионов Никита Алексеевич'),
(12, 'Ярославль, Урицкого 36', 'Иванов Петр Васильевич');

SELECT
	*
FROM
	[dbo].[Покупатель] C
	LEFT JOIN [dbo].[Заказ] O ON C.id = O.id_покупателя


INSERT INTO [dbo].[Издательство](id, [адрес], [название], [телефон]) VALUES
(11, 'Рыбинск, ул. Колесова 94', 'ЧитайГород', '8800222235'),
(12, 'Якутск, ул. Пушкина 69', 'ДетскийДом', '8900333325')


SELECT * FROM [dbo].[Издательство]

SELECT
	*
FROM
	[dbo].[Издательство] p
	LEFT JOIN [dbo].[Тираж_книги] c ON c.id_издательства = p.id


SELECT
	*
FROM
	[dbo].[Заказ] O
	RIGHT JOIN [dbo].[Покупатель] C ON C.id = O.id_покупателя


SELECT
	*
FROM
	[dbo].[Тираж_книги] c
	RIGHT JOIN [dbo].[Издательство] p ON c.id_издательства = p.id


SELECT * FROM [dbo].[Книга_Жанр]

SELECT
	J.название,
	COUNT(BJ.[id_жанра]) AS 'Сколько книг таких жанров'
FROM
	[dbo].[Книга_Жанр] BJ
	INNER JOIN [dbo].[Жанр] J ON BJ.id_жанра = J.id 
GROUP BY
	BJ.id_жанра, J.название


SELECT * FROM [dbo].[Тираж_книги]

SELECT
	IZ.[название],
	SUM(T.[число_экземпляров]) AS 'Сколько экземпляров всего принадлежит каждому издательству'
FROM
	[dbo].[Тираж_книги] T
	INNER JOIN [dbo].[Издательство] IZ ON T.id_издательства = IZ.id
GROUP BY
	T.id_издательства, IZ.[название]


SELECT * FROM [dbo].[Книга_Автор]

SELECT 
	[id_книги] as 'У книги больше 1 автора'
FROM 
	[dbo].[Книга_Автор]
GROUP BY
	[id_книги]
HAVING
	count(*) > 1

select * from [dbo].[Тираж_книги]

SELECT
	[дата_поступления] as 'дни когда поступило более 1000 экз.'
FROM
	[dbo].[Тираж_книги]
GROUP BY
	[дата_поступления]
HAVING
	sum([число_экземпляров]) > 1000


SELECT * FROM [dbo].[Автор]

INSERT INTO [dbo].[Автор](id,[имя]) VALUES (13,'Константин Владимиров')

DELETE FROM [dbo].[Автор]
WHERE id = 13


SELECT
	A.id
FROM
	[dbo].[Автор] A
WHERE EXISTS(
	SELECT 1
	FROM [dbo].[Книга_Автор] BA
	WHERE BA.id_автора IN (A.id)
	)


SELECT DISTINCT BA.id_автора
FROM [dbo].[Книга_Автор] BA
WHERE BA.id_книги IN (
    SELECT BA2.id_книги
    FROM [dbo].[Книга_Автор] BA2
    WHERE BA2.id_автора != BA.id_автора
);


SELECT DISTINCT A.id, A.имя
FROM [dbo].[Автор] A
WHERE EXISTS (
    SELECT 1
    FROM [dbo].[Книга_Автор] BA
    WHERE BA.id_автора = A.id
    AND NOT EXISTS (
        SELECT 1
        FROM [dbo].[Книга_Автор] BA1
        WHERE BA1.id_книги = BA.id_книги
        AND BA1.id_автора != BA.id_автора
    )
)

GO

CREATE VIEW CountBooksPublishers AS
SELECT
	IZ.[название],
	SUM(T.[число_экземпляров]) AS 'Сколько экземпляров всего принадлежит каждому издательству'
FROM
	[dbo].[Тираж_книги] T
	INNER JOIN [dbo].[Издательство] IZ ON T.id_издательства = IZ.id
GROUP BY
	T.id_издательства, IZ.[название]


GO

CREATE VIEW AuthorWhoHasSoauthor AS
SELECT DISTINCT BA.id_автора
FROM [dbo].[Книга_Автор] BA
WHERE BA.id_книги IN (
    SELECT BA2.id_книги
    FROM [dbo].[Книга_Автор] BA2
    WHERE BA2.id_автора != BA.id_автора
);


go

select * from AuthorWhoHasSoauthor

go

with cte_query as (
select [id_автора]
from [dbo].[Книга_Автор]
)

select * 
from cte_query

go 

with cte_query2 as (
select [название]
from [dbo].[Издательство]
)

select * 
from cte_query2
where [название] = 'АСТ'

go

select [id_книги], [id_автора],
row_number() over (order by [id_автора] desc),
rank() over (order by [id_автора] desc),
dense_rank() over (order by [id_автора] desc)
from [dbo].[Книга_Автор];

select * from [dbo].[Книга_Автор]


SELECT [id_книги] 
FROM [dbo].[Книга_Жанр] 
WHERE [id_жанра] = (SELECT [id] FROM [dbo].[Жанр] WHERE [название] = 'Фантастика')
INTERSECT
SELECT [id_книги]
FROM [dbo].[Книга_Тема] 
WHERE [id_темы] = (SELECT [id] FROM [dbo].[Тема] WHERE [название] = 'Путешествия');


SELECT [имя] AS [Имя] 
FROM [dbo].[Автор]

UNION ALL

SELECT [ФИО] AS [Имя]
FROM [dbo].[Покупатель];


SELECT [имя] FROM [dbo].[Автор]
EXCEPT
SELECT A.[имя] 
FROM [dbo].[Автор] A
JOIN [dbo].[Книга_Автор] KA ON A.[id] = KA.[id_автора]
JOIN [dbo].[Книга_Жанр] KG ON KA.[id_книги] = KG.[id_книги]
JOIN [dbo].[Жанр] G ON KG.[id_жанра] = G.[id]
WHERE G.[название] = 'Детектив'
ORDER BY [имя];


SELECT 
    CASE WHEN [статус] = 1 THEN 'Выполнен' ELSE 'Не выполнен' END AS [Статус заказа],
    COUNT(*) AS [Количество заказов],
    SUM(T.[цена_продажи]) AS [Общая сумма продаж]
FROM [dbo].[Заказ] Z
JOIN [dbo].[Книга_экземпляр] KE ON Z.[id] = KE.[id_заказа]
JOIN [dbo].[Тираж_книги] T ON KE.[id_тиража_книги] = T.[id]
GROUP BY [статус];


SELECT * FROM (
    SELECT [название] AS JName, COUNT(*) AS Count
    FROM [dbo].[Книга_Жанр] BJ
	JOIN [dbo].[Жанр] J ON BJ.id_жанра = J.id
    GROUP BY BJ.id_жанра, J.название
) AS SourceTable
PIVOT (
    SUM(Count) FOR JName IN ([Фантастика], [Детектив], [Роман],
	[Наука], [Поэзия], [Биография], [Ужасы], [Комедия], [Триллер],
	[Фэнтези])
) AS PivotTable;


SELECT JName, Count
FROM (
    SELECT * FROM (
        SELECT [название] AS JName, COUNT(*) AS Count
        FROM [dbo].[Книга_Жанр] BJ
        JOIN [dbo].[Жанр] J ON BJ.id_жанра = J.id
        GROUP BY BJ.id_жанра, J.название
    ) AS SourceTable
    PIVOT (
        SUM(Count) FOR JName IN ([Фантастика], [Детектив], [Роман],
        [Наука], [Поэзия], [Биография], [Ужасы], [Комедия], [Триллер],
        [Фэнтези])
    ) AS PivotTable
) AS P
UNPIVOT (
    Count FOR JName IN ([Фантастика], [Детектив], [Роман],
    [Наука], [Поэзия], [Биография], [Ужасы], [Комедия], [Триллер],
    [Фэнтези])
) AS UnpivotTable;


select * from [dbo].[Жанр]


use bookshop;

select * from [dbo].[Автор]

insert into [dbo].[Автор]([имя]) values ('Лев Толстой')

select * from [dbo].[Книга_образец]

insert into [dbo].[Книга_образец] values ('Юность')

select * from [dbo].[Книга_Жанр]

select * from [dbo].[Жанр]

insert into [dbo].[Жанр]([название]) values ('Автобиографическая трилогия')

insert into [dbo].[Книга_Жанр]([id_книги],[id_жанра]) values
(18,11)

select * from [dbo].[Тема]

insert into [dbo].[Тема]([название]) values ('Социальная несправедливость')

select * from [dbo].[Книга_Тема] -- 15 16 17 18

insert into [dbo].[Книга_Тема]([id_книги], [id_темы]) values
(15,10),(16,11),(17,10),(18,11)

select * from [dbo].[Тираж_книги]

insert into [dbo].[Тираж_книги] values ('2025-10-08', '2025-10-07', 100, 450, 250, 4)

select * from [dbo].[Книга_экземпляр]

insert into [dbo].[Книга_экземпляр]([id_тиража_книги],[id_образца], [id_заказа]) values
(24, 16, 2),(24, 16, 2), (24, 16, 2)



select * from [dbo].[Заказ]

select * from [dbo].[Книга_Автор]

insert into [dbo].[Книга_Автор] values
(15,16), (16,16), (17,16), (18,16)

WITH cteTol AS (
    SELECT 1828 AS start_year
    
    UNION ALL
    
    SELECT start_year + 10
    FROM cteTol
    WHERE start_year < 2026
)
SELECT DISTINCT 
    BS.название AS 'Название книги', 
    B.шифр AS 'Шифр экземпляра',
    c.start_year AS 'Юбилейный год'
FROM cteTol c
join [dbo].[Тираж_книги] T on YEAR(T.дата_поступления) = c.start_year
join [dbo].[Книга_экземпляр] B on B.id_тиража_книги = T.id
join [dbo].[Книга_образец] BS on BS.id = B.id_образца
join [dbo].[Книга_Автор] BA on BA.id_книги = B.id_образца
join [dbo].[Автор] A on A.id = BA.id_автора
where
    A.имя = 'Лев Толстой'

select * from [dbo].[Тираж_книги]


select
	BT.id as 'Номер тиража'
from
	[dbo].[Тираж_книги] BT
where
	BT.дата_поступления >= DATEADD(MONTH, -1, GETDATE())
	AND NOT EXISTS (
		select 1
		from 
		[dbo].[Книга_экземпляр] B
		join [dbo].[Заказ] O on O.id = B.id_заказа
		where
			BT.id = B.id_тиража_книги
			AND (O.статус IN (1,2))
	)


select
	min(T.цена_продажи - T.закупочная_цена) 
	as 'Минимальная наценка',
	max(T.цена_продажи - T.закупочная_цена) 
	as 'Максимальная наценка'
from
	[dbo].[Тираж_книги] T

select * from [dbo].[Тираж_книги]

update [dbo].[Тираж_книги]
set [цена_продажи] = 1000
where id in (23,24)


