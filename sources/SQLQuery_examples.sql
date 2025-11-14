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
		left join [dbo].[Заказ] O on O.id = B.id_заказа
		where
			BT.id = B.id_тиража_книги
			AND (O.статус != 0) 
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



WITH MinMarkup AS (
    SELECT MIN(T.цена_продажи - T.закупочная_цена) AS GlobalMinMarkup
    FROM [dbo].[Тираж_книги] T
)
SELECT
    T.id AS 'Номер тиража',
    P.название,
    (T.цена_продажи - T.закупочная_цена) AS 'Минимальная наценка'
FROM
    [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
WHERE
    (T.цена_продажи - T.закупочная_цена) = (SELECT GlobalMinMarkup FROM MinMarkup);


WITH MinMarkup AS (
    SELECT MAX(T.цена_продажи - T.закупочная_цена) AS GlobalMinMarkup
    FROM [dbo].[Тираж_книги] T
)
SELECT
    T.id AS 'Номер тиража',
    P.название,
    (T.цена_продажи - T.закупочная_цена) AS 'Максимальная наценка'
FROM
    [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
WHERE
    (T.цена_продажи - T.закупочная_цена) = (SELECT GlobalMinMarkup FROM MinMarkup);



SELECT
    P.название AS 'Издательство',
    T.id AS 'Номер тиража',
    (T.закупочная_цена - T.цена_продажи) AS 'Убыток'
FROM
    [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
WHERE
    T.цена_продажи < T.закупочная_цена  -- Убыточные тиражи
    AND T.дата_поступления < DATEADD(YEAR, -1, GETDATE())  -- Более года назад



SELECT
    P.название AS 'Издательство',
    T.id AS 'Номер тиража',
    (T.закупочная_цена - T.цена_продажи) AS 'Убыток'
FROM
    [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
WHERE
    T.цена_продажи < T.закупочная_цена
    AND T.дата_поступления < DATEADD(YEAR, -1, GETDATE())


-------------------------------------------------------------------------

WITH TotalBook AS (
    SELECT 
        KE.id_тиража_книги,
        COUNT(*) AS bookCount
    FROM [dbo].[Книга_экземпляр] KE
    JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа
    WHERE Z.статус = 0
    GROUP BY KE.id_тиража_книги
),

TotalTirazh AS (
    SELECT
        T.id AS TirazhId,
        T.число_экземпляров,
        T.дата_поступления,
        T.цена_продажи,
        T.закупочная_цена,
        P.название AS Publisher,
        KO.название AS Book
    FROM [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
    JOIN [dbo].[Книга_экземпляр] KE ON KE.id_тиража_книги = T.id
    JOIN [dbo].[Книга_образец] KO ON KO.id = KE.id_образца
    WHERE T.дата_поступления <= DATEADD(YEAR, -1, GETDATE())
)

SELECT DISTINCT
    TI.Publisher AS 'Издательство',
    TI.Book AS 'Книга',
    TI.TirazhId AS 'Номер тиража',
    ((TI.число_экземпляров - ISNULL(P.bookCount, 0)) * TI.закупочная_цена) 
    - (ISNULL(P.bookCount, 0) * (TI.цена_продажи - TI.закупочная_цена)) AS 'Убыток'
FROM TotalTirazh TI
LEFT JOIN TotalBook P ON P.id_тиража_книги = TI.TirazhId
WHERE (
    (TI.число_экземпляров - ISNULL(P.bookCount, 0)) * TI.закупочная_цена
) - (
    ISNULL(P.bookCount, 0) * (TI.цена_продажи - TI.закупочная_цена)
) > 0


--------------------------------------------------------------------


WITH SoldBooks AS (
    SELECT 
        KE.id_образца,
        COUNT(*) AS SoldCount
    FROM [dbo].[Книга_экземпляр] KE
    JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа
    WHERE Z.статус = 0
    GROUP BY KE.id_образца
)

SELECT 
    KO.название AS 'Название книги',
    SB.SoldCount AS 'Количество проданных экземпляров'
FROM SoldBooks SB
JOIN [dbo].[Книга_образец] KO ON KO.id = SB.id_образца
WHERE SB.SoldCount = (
    SELECT MAX(SoldCount) FROM SoldBooks
)

---------------------------------
with tmp as (
select
    k.id_образца,
    k.id_тиража_книги,
    count(*) as BooksCount -- Сколько книг одного образца в каждом тираже продано
from
    [dbo].[Книга_экземпляр] k
    join [dbo].[Заказ] z on k.id_заказа = z.id
where z.статус = 0
group by
    k.id_тиража_книги, k.id_образца
)


select
    t.id, tmp.id_образца, tmp.BooksCount
from
    
    [dbo].[Тираж_книги] t
    left join tmp on tmp.id_тиража_книги = t.id
order by
    t.id

--------------------------

WITH SoldBooks AS (
    SELECT 
        KO.id AS id_образца,
        COUNT(Z.id) AS SoldCount
    FROM [dbo].[Книга_образец] KO
    JOIN [dbo].[Книга_экземпляр] KE ON KE.id_образца = KO.id
    LEFT JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа AND Z.статус = 0       -- именно 0 чтобы после посчитать по этому атрибуту количество
    GROUP BY KO.id
)
SELECT
    KO.название AS 'Название книги',
    SB.SoldCount AS 'Количество проданных экземпляров'
FROM SoldBooks SB
JOIN [dbo].[Книга_образец] KO ON KO.id = SB.id_образца
WHERE SB.SoldCount = (
    SELECT MAX(SoldCount) FROM SoldBooks
);

---------

WITH SoldBooks AS (
    SELECT 
        KE.id_образца,
        COUNT(Z.id) AS SoldCount
    FROM [dbo].[Книга_образец] KO
    LEFT JOIN [dbo].[Книга_экземпляр] KE ON KE.id_образца = KO.id
    LEFT JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа AND Z.статус = 0
    WHERE Z.статус = 0
    GROUP BY KE.id_образца
)

SELECT 
    KO.название AS 'Название книги',
    SB.SoldCount AS 'Количество проданных экземпляров'
FROM SoldBooks SB
JOIN [dbo].[Книга_образец] KO ON KO.id = SB.id_образца
WHERE SB.SoldCount = (
    SELECT MAX(SoldCount) FROM SoldBooks
)


----------------Lab4---------------------

GO
CREATE PROC [dbo].LossEditionCount
AS
WITH TotalBook AS (
    SELECT 
        KE.id_тиража_книги,
        COUNT(*) AS bookCount
    FROM [dbo].[Книга_экземпляр] KE
    JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа
    WHERE Z.статус = 0
    GROUP BY KE.id_тиража_книги
),

TotalTirazh AS (
    SELECT
        T.id AS TirazhId,
        T.число_экземпляров,
        T.дата_поступления,
        T.цена_продажи,
        T.закупочная_цена,
        P.название AS Publisher,
        KO.название AS Book
    FROM [dbo].[Тираж_книги] T
    JOIN [dbo].[Издательство] P ON P.id = T.id_издательства
    JOIN [dbo].[Книга_экземпляр] KE ON KE.id_тиража_книги = T.id
    JOIN [dbo].[Книга_образец] KO ON KO.id = KE.id_образца
    WHERE T.дата_поступления <= DATEADD(MONTH, -1, GETDATE())
)

SELECT DISTINCT
    TI.Publisher AS 'Издательство',
    TI.Book AS 'Книга',
    TI.TirazhId AS 'Номер тиража',
    ((TI.число_экземпляров - ISNULL(P.bookCount, 0)) * TI.закупочная_цена) 
    - (ISNULL(P.bookCount, 0) * (TI.цена_продажи - TI.закупочная_цена)) AS 'Убыток'
FROM TotalTirazh TI
LEFT JOIN TotalBook P ON P.id_тиража_книги = TI.TirazhId
WHERE (
    (TI.число_экземпляров - ISNULL(P.bookCount, 0)) * TI.закупочная_цена
) - (
    ISNULL(P.bookCount, 0) * (TI.цена_продажи - TI.закупочная_цена)
) > 0

GO
EXEC LossEditionCount

GO
CREATE PROC [dbo].theme_books
@book_theme VARCHAR(100)
AS
SELECT B.название
FROM [dbo].[Книга_Тема] BT
    JOIN [dbo].[Книга_образец] B ON B.id = BT.id_книги
    JOIN [dbo].[Тема] T ON T.id = BT.id_темы
WHERE
    T.название = @book_theme

GO
DECLARE @theme varchar(100) = 'История'
EXEC theme_books @theme

select * from [dbo].[Тема]


----
GO
CREATE PROC [dbo].most_popular_book
@author_name VARCHAR(255),
@book_name VARCHAR(255) OUT
AS
    declare @author_id INT

    select TOP 1 @author_id = id
    from [dbo].[Автор]
    where имя = @author_name

    select @book_name = b.название
    from [dbo].[Книга_экземпляр] be
    join [dbo].[Книга_образец] b on b.id = be.id_образца
    join [dbo].[Книга_Автор] ba on ba.id_книги = b.id and ba.id_автора = @author_id
    join [dbo].[Заказ] o on o.id = be.id_заказа and o.статус = 0
    group by b.название
    order by count(*) desc

GO

declare @book nvarchar(255)

EXEC [dbo].most_popular_book @author_name = 'Иван Иванов', @book_name = @book OUTPUT;

SELECT @book as 'Must popular book';

exec sp_columns @table_name = 'Книга_образец'
select * from [dbo].[Автор]


select * from [dbo].[Заказ]
update [dbo].[Заказ]
set статус = 0
where id in (1,5,6,7,8)
select * from [dbo].[Книга_экземпляр]
select * from [dbo].[Заказ]

update [dbo].[Книга_экземпляр]
set id_заказа = 1
where
    (шифр between 27 and 97)

GO

CREATE PROC [dbo].[GetTotalBook]
AS
BEGIN
    SELECT 
        KE.id_тиража_книги,
        COUNT(*) AS bookCount
    FROM [dbo].[Книга_экземпляр] KE
    JOIN [dbo].[Заказ] Z ON Z.id = KE.id_заказа
    WHERE Z.статус = 0
    GROUP BY KE.id_тиража_книги;
END;
GO

CREATE OR ALTER PROC [dbo].[GetLossReport]
AS
BEGIN

    CREATE TABLE #TotalBook (
        id_тиража_книги INT,
        bookCount INT
    );

    INSERT INTO #TotalBook
    EXEC [dbo].[GetTotalBook];

    DECLARE @COUNT_TIRAZH INT;
    SELECT @COUNT_TIRAZH = COUNT(*) FROM [dbo].[Тираж_книги];

    WITH TotalTirazh AS (
        SELECT
            T.id AS TirazhId,
            T.число_экземпляров,
            T.цена_продажи,
            T.закупочная_цена
        FROM [dbo].[Тираж_книги] T
        JOIN [dbo].[Книга_экземпляр] KE ON KE.id_тиража_книги = T.id
    )

    SELECT DISTINCT
        COUNT(DISTINCT TI.TirazhId) AS 'Количество убыточных тиражей',
        COUNT(DISTINCT TI.TirazhId) * 1.0 / @COUNT_TIRAZH * 100 AS 'Процент убыточных тиражей'
    FROM TotalTirazh TI
    JOIN #TotalBook P ON P.id_тиража_книги = TI.TirazhId
    WHERE (
        (TI.число_экземпляров - ISNULL(P.bookCount, 0)) * TI.закупочная_цена
    ) - (
        ISNULL(P.bookCount, 0) * (TI.цена_продажи - TI.закупочная_цена)
    ) > 0;
        print @COUNT_TIRAZH;

    DROP TABLE #TotalBook;
END;
GO

EXEC [dbo].[GetLossReport]

use bookshop

GO
CREATE OR ALTER FUNCTION [dbo].[NameOfMostPopularBook]()
RETURNS NVARCHAR(255)
AS
BEGIN

    DECLARE @BookName NVARCHAR(255);

    SELECT TOP 1
        @BookName = B.название
    FROM
        [dbo].[Книга_экземпляр] BE
        JOIN [dbo].[Заказ] O ON O.id = BE.id_заказа AND O.статус = 0
        JOIN [dbo].[Книга_образец] B ON B.id = BE.id_образца
    GROUP BY
        BE.id_образца, B.название
    ORDER BY
        COUNT(*) DESC

    RETURN @BookName;
END

GO
SELECT [dbo].[NameOfMostPopularBook]() AS 'MUST POPULAR BOOK'

GO
CREATE FUNCTION TABLE_SOLD_BOOKS()
RETURNS TABLE
AS
RETURN (
    SELECT *
    FROM [dbo].[Книга_образец] B
    WHERE
        NOT EXISTS (
            SELECT 1
            FROM [dbo].[Книга_экземпляр] BE
            JOIN [dbo].[Заказ] O ON O.id = BE.id_заказа AND O.статус = 0 
                AND B.id = BE.id_образца
        )
)

GO
SELECT * FROM TABLE_SOLD_BOOKS()


GO

CREATE FUNCTION popular_autors()
RETURNS @MyTable TABLE (
    Author NVARCHAR(255)
)
AS
BEGIN
    

    INSERT INTO @MyTable (Author)
    SELECT
        A.имя
    FROM
        [dbo].[Книга_экземпляр] BE
        JOIN [dbo].[Заказ] O ON O.id = BE.id_заказа AND O.статус = 0
        JOIN [dbo].[Книга_образец] B ON B.id = BE.id_образца
        JOIN [dbo].[Книга_Автор] BA ON BA.id_книги = B.id
        JOIN [dbo].[Автор] A ON A.id = BA.id_автора
    GROUP BY
        A.имя
    ORDER BY
        COUNT(*) DESC

    RETURN;
END;

GO

SELECT * FROM popular_autors()


GO

