
---- ВЕРШИНЫ ----

GO

IF OBJECT_ID('dbo.[Автор]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Автор] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [имя] NVARCHAR(255) NOT NULL
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Жанр]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Жанр] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Тема]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Тема] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Книга_образец]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_образец] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Издательство]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Издательство] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL,
        [телефон] NVARCHAR(11),
        [адрес] NVARCHAR(255)
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Покупатель]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Покупатель] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [ФИО] NVARCHAR(255) NOT NULL,
        [адрес] NVARCHAR(255)
    ) AS NODE;
END
GO


IF OBJECT_ID('dbo.[Заказ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Заказ] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [статус] INT NOT NULL DEFAULT(0),
        [дата] DATE NOT NULL,
        CHECK ([статус] > -1 AND [статус] < 3)
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Тираж_книги]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Тираж_книги] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [дата_поступления] DATE NOT NULL,
        [дата_издания] DATE NOT NULL,
        [цена_продажи] DECIMAL(10,2) NOT NULL,
        [число_экземпляров] INT NOT NULL,
        [закупочная_цена] DECIMAL(10,2) NOT NULL,
        CHECK ([число_экземпляров] >= 0 AND [закупочная_цена] >= 0 AND [цена_продажи] >= 0 
              AND [дата_поступления] >= [дата_издания])
    ) AS NODE;
END
GO

IF OBJECT_ID('dbo.[Книга_экземпляр]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_экземпляр] (
        [шифр] INT IDENTITY(1,1) PRIMARY KEY
    ) AS NODE;
END
GO




------ УЗЛЫ -----


IF OBJECT_ID('dbo.[СОЗДАЕТ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[СОЗДАЕТ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[ПРОДАЕТСЯ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ПРОДАЕТСЯ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[ИМЕЕТ_ЖАНР]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ИМЕЕТ_ЖАНР] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[ПРИНАДЛЕЖИТ_К_ТЕМЕ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ПРИНАДЛЕЖИТ_ТЕМЕ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[НАПИСАЛ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[НАПИСАЛ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[КАКУЮ_КНИГУ_ИЗДАЕТ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[КАКУЮ_КНИГУ_ИЗДАЕТ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[ИЗДАЕТСЯ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ИЗДАЕТСЯ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[РЕАЛИЗУЕТ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[РЕАЛИЗУЕТ] AS EDGE;
END
GO

IF OBJECT_ID('dbo.[ПЕЧАТАЕТ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[ПЕЧАТАЕТ] AS EDGE;
END
GO



---- ВСТАВКА ДАННЫХ -----


INSERT INTO [dbo].[Автор] ([имя]) VALUES 
('Лев Толстой'), 
('Федор Достоевский'), 
('Михаил Лермонтов'),
('Николай Гоголь');
GO


INSERT INTO [dbo].[Жанр] ([название]) VALUES 
('Классика'), 
('Роман-эпопея'), 
('Философский роман'),
('Повесть');
GO



INSERT INTO [dbo].[Тема] ([название]) VALUES 
('Война и мир'), 
('Мораль и этика'), 
('Судьба человека'),
('Русская провинция');
GO



INSERT INTO [dbo].[Издательство] ([название], [телефон], [адрес]) VALUES 
('Издательство "Эксмо"', '12345678901', 'Москва, ул. Большая Садовая, 1'), 
('Издательство "АСТ"', '98765432109', 'Санкт-Петербург, Невский пр., 100');
GO



INSERT INTO [dbo].[Покупатель] ([ФИО], [адрес]) VALUES 
('Иванов Иван Иванович', 'Москва, ул. Ленина, 5, кв. 10'), 
('Петров Петр Петрович', 'Тверь, ул. Мира, 2, кв. 3');
GO



INSERT INTO [dbo].[Книга_образец] ([название]) VALUES 
('Война и мир'), 
('Преступление и наказание'), 
('Герой нашего времени'),
('Мертвые души');
GO



INSERT INTO [dbo].[Заказ] ([статус], [дата]) VALUES 
(0, '2025-12-01'), 
(1, '2025-12-05');
GO



INSERT INTO [dbo].[Тираж_книги] ([дата_поступления], [дата_издания], [цена_продажи], [число_экземпляров], [закупочная_цена]) VALUES 
('2025-11-20', '2024-01-15', 850.50, 50, 400.00),
('2025-12-01', '2023-05-20', 600.00, 100, 300.00);
GO



INSERT INTO [dbo].[Книга_экземпляр] DEFAULT VALUES;
INSERT INTO [dbo].[Книга_экземпляр] DEFAULT VALUES;




INSERT INTO [dbo].[НАПИСАН_АВТОРОМ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Автор] WHERE [id] = 1)
),
(
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 2),
    (SELECT $node_id FROM [dbo].[Автор] WHERE [id] = 2)
);
GO


INSERT INTO [dbo].[ИМЕЕТ_ЖАНР] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Жанр] WHERE [id] = 1)
),
(
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Жанр] WHERE [id] = 2)
);
GO


INSERT INTO [dbo].[ПРИНАДЛЕЖИТ_ТЕМЕ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Тема] WHERE [id] = 1)
);
GO


INSERT INTO [dbo].[СОЗДАЕТ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Покупатель] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Заказ] WHERE [id] = 1)
);
GO


INSERT INTO [dbo].[ПЕЧАТАЕТ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Издательство] WHERE [id] = 1),
    (SELECT $node_id FROM [dbo].[Тираж_книги] WHERE [id] = 1)
);
GO


INSERT INTO [dbo].[РЕАЛИЗУЕТ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Книга_экземпляр] WHERE [шифр] = 1),
    (SELECT $node_id FROM [dbo].[Книга_образец] WHERE [id] = 1)
);
GO


INSERT INTO [dbo].[ИЗДАЕТСЯ] ($from_id, $to_id) VALUES
(
    (SELECT $node_id FROM [dbo].[Книга_экземпляр] WHERE [шифр] = 1),
    (SELECT $node_id FROM [dbo].[Тираж_книги] WHERE [id] = 1)
);
GO



----- a ------

WITH cteTol AS (
    SELECT 1878 AS JubileeYear
    UNION ALL
    SELECT JubileeYear + 10
    FROM cteTol
    WHERE JubileeYear < 2026
)
SELECT DISTINCT 
    BS.название AS 'Название книги', 
    B.шифр AS 'Шифр экземпляра',
    c.JubileeYear AS 'Юбилейный год'
FROM 
    cteTol AS c,
    [dbo].[Тираж_книги] AS T,
    [dbo].[Автор] AS A,
    [dbo].[написал] AS W, 
    [dbo].[Книга_образец] AS BS, 
    [dbo].[реализует] AS R, 
    [dbo].[Книга_экземпляр] AS B, 
    [dbo].[издается] AS Pub
WHERE
    YEAR(T.дата_поступления) = c.JubileeYear
    AND A.[имя] = 'Лев Толстой'
    AND MATCH(A-(W)->BS<-(R)-B-(Pub)->T); 


----- b ------

SELECT
    BT.id AS 'Номер тиража'
FROM
    [dbo].[Тираж_книги] AS BT 
WHERE
    BT.дата_поступления >= DATEADD(MONTH, -1, GETDATE())
    
    AND NOT EXISTS (
        SELECT 1
        FROM
            [dbo].[Книга_экземпляр] AS B, 
            [dbo].[издается] AS Pub,      
            [dbo].[продается] AS Sold,     
            [dbo].[Заказ] AS O            
        WHERE
            MATCH(O-(Sold)->B-(Pub)->BT)
            AND O.статус IN (1, 2)
    );



---- с ----


WITH MinMarkup AS (
    SELECT
        MIN(T.цена_продажи - T.закупочная_цена) AS GlobalMinMarkup
    FROM
        [dbo].[Тираж_книги] AS T
)
SELECT
    T.id AS 'Номер тиража',
    P.название AS 'Название издательства',
    (T.цена_продажи - T.закупочная_цена) AS 'Минимальная наценка'
FROM
    [dbo].[Издательство] AS P,
    [dbo].[Печатает] AS Печатает,
    [dbo].[Книга_образец] AS B,
    [dbo].[Реализует] AS Реализует,
    [dbo].[Книга_экземпляр] AS KE,
    [dbo].[Издается] AS Издается,
    [dbo].[Тираж_книги] AS T
WHERE
    MATCH(P-(Печатает)->B-(Реализует)->KE-(Издается)->T)
    AND (T.цена_продажи - T.закупочная_цена) = (SELECT GlobalMinMarkup FROM MinMarkup);



---- d ----



SELECT DISTINCT
    P.название AS 'Издательство',
    B.название AS 'Книга',
    T.id AS 'Номер тиража',
    ((T.число_экземпляров - ISNULL(OrderCounts.bookCount, 0)) * T.закупочная_цена)
    - (ISNULL(OrderCounts.bookCount, 0) * (T.цена_продажи - T.закупочная_цена)) AS Убыток
FROM
    [dbo].[Издательство] AS P,
    [dbo].[Печатает] AS Печатает,
    [dbo].[Книга_образец] AS B,
    [dbo].[Реализует] AS Реализует,
    [dbo].[Книга_экземпляр] AS KE,
    [dbo].[Издается] AS Издается,
    [dbo].[Тираж_книги] AS T,
    (
        SELECT
            TirazhId,
            COUNT(*) AS bookCount
        FROM
        (
            SELECT
                Z.id AS OrderId,
                Z.статус,
                Tirazh.id AS TirazhId
            FROM
                [dbo].[Заказ] AS Z,
                [dbo].[Создает] AS Создает,
                [dbo].[Покупатель] AS Покупатель,
                [dbo].[Продается] AS Продается,
                [dbo].[Книга_экземпляр] AS КЭ,
                [dbo].[Издается] AS Изд,
                [dbo].[Тираж_книги] AS Tirazh
            WHERE
                MATCH(Z-(Создает)->Покупатель<-(Продается)-КЭ-(Изд)->Tirazh)
                AND Z.статус = 0
        ) AS SubQuery
        GROUP BY TirazhId
    ) AS OrderCounts

WHERE
    MATCH(P-(Печатает)->B-(Реализует)->KE-(Издается)->T)
    AND T.дата_поступления <= DATEADD(YEAR, -1, GETDATE())
    AND T.id = OrderCounts.TirazhId
    AND (
        ((T.число_экземпляров - ISNULL(OrderCounts.bookCount, 0)) * T.закупочная_цена)
        - (ISNULL(OrderCounts.bookCount, 0) * (T.цена_продажи - T.закупочная_цена))
    ) > 0;

--- e ---

WITH SoldBooks AS (
    SELECT
        KO.id AS id_obrazca,
        COUNT(*) AS SoldCount
    FROM
        [dbo].[Книга_образец] AS KO,
        [dbo].[Продается] AS P,
        [dbo].[Книга_экземпляр] AS KE,
        [dbo].[Создает] AS C,
        [dbo].[Заказ] AS Z
    WHERE
        MATCH(KO-(P)->KE-(C)->Z)
        AND Z.статус = 0
    GROUP BY
        KO.id
),
MaxSoldCount AS (
    SELECT
        MAX(SoldCount) AS MaxSoldCount
    FROM
        SoldBooks
)
SELECT
    KO.название AS 'Название книги',
    SB.SoldCount AS 'Количество проданных экземпляров'
FROM
    SoldBooks AS SB
JOIN
    [dbo].[Книга_образец] AS KO ON KO.id = SB.id_obrazca
JOIN
    MaxSoldCount AS MSC ON SB.SoldCount = MSC.MaxSoldCount;
