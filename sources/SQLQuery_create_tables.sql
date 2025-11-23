USE [bookshop];

-- Таблица Автор
IF OBJECT_ID('dbo.[Автор]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Автор] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [имя] NVARCHAR(255) NOT NULL
    );
END

-- Таблица Жанр
IF OBJECT_ID('dbo.[Жанр]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Жанр] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    );
END

-- Таблица Тема
IF OBJECT_ID('dbo.[Тема]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Тема] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    );
END

-- Таблица Книга_образец
IF OBJECT_ID('dbo.[Книга_образец]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_образец] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL
    );
END

-- Таблица Издательство
IF OBJECT_ID('dbo.[Издательство]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Издательство] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [название] NVARCHAR(255) NOT NULL,
        [телефон] NVARCHAR(11),
        [адрес] NVARCHAR(255)
    );
END

-- Таблица Покупатель
IF OBJECT_ID('dbo.[Покупатель]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Покупатель] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [ФИО] NVARCHAR(255) NOT NULL,
        [адрес] NVARCHAR(255)
    );
END

-- Таблица Заказ
IF OBJECT_ID('dbo.[Заказ]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Заказ] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [статус] INT NOT NULL DEFAULT(0),
        [дата] DATE NOT NULL,
        [id_покупателя] INT,
        FOREIGN KEY ([id_покупателя]) REFERENCES [dbo].[Покупатель]([id]) ON DELETE CASCADE,
        CHECK ([статус] > -1 AND [статус] < 3)
    );
END

-- Таблица Тираж_книги
IF OBJECT_ID('dbo.[Тираж_книги]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Тираж_книги] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [дата_поступления] DATE NOT NULL,
        [дата_издания] DATE NOT NULL,
        [цена_продажи] DECIMAL(10,2) NOT NULL,
        [число_экземпляров] INT NOT NULL,
        [закупочная_цена] DECIMAL(10,2) NOT NULL,
        [id_издательства] INT,
        [id_книги_образца] INT,
        FOREIGN KEY ([id_издательства]) REFERENCES [dbo].[Издательство]([id]) ON DELETE SET NULL,
        FOREIGN KEY ([id_книги_образца]) REFERENCES [dbo].[Книга_образец]([id]) ON DELETE SET NULL,
        CHECK ([число_экземпляров] >= 0 AND [закупочная_цена] >= 0 AND [цена_продажи] >= 0 
              AND [дата_поступления] >= [дата_издания])
    );
END



-- Таблица Книга_экземпляр
IF OBJECT_ID('dbo.[Книга_экземпляр]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_экземпляр] (
        [шифр] INT IDENTITY(1,1) PRIMARY KEY,
        [id_тиража_книги] INT NOT NULL,
        [id_образца] INT NOT NULL,
        [id_заказа] INT NULL,
        FOREIGN KEY ([id_тиража_книги]) REFERENCES [dbo].[Тираж_книги]([id]) ON DELETE CASCADE,
        FOREIGN KEY ([id_образца]) REFERENCES [dbo].[Книга_образец]([id]) ON DELETE CASCADE,
        FOREIGN KEY ([id_заказа]) REFERENCES [dbo].[Заказ]([id]) ON DELETE SET NULL

    );
END

-- Таблица Книга_Автор (связующая)
IF OBJECT_ID('dbo.[Книга_Автор]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_Автор] (
        [id_книги] INT NOT NULL,
        [id_автора] INT NOT NULL,
        PRIMARY KEY ([id_автора], [id_книги]),
        FOREIGN KEY ([id_автора]) REFERENCES [dbo].[Автор]([id]),
        FOREIGN KEY ([id_книги]) REFERENCES [dbo].[Книга_образец]([id])
    );
END

-- Таблица Книга_Жанр (связующая)
IF OBJECT_ID('dbo.[Книга_Жанр]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_Жанр] (
        [id_книги] INT NOT NULL,
        [id_жанра] INT NOT NULL,
        PRIMARY KEY ([id_книги], [id_жанра]),
        FOREIGN KEY ([id_книги]) REFERENCES [dbo].[Книга_образец]([id]),
        FOREIGN KEY ([id_жанра]) REFERENCES [dbo].[Жанр]([id])
    );
END

-- Таблица Книга_Тема (связующая)
IF OBJECT_ID('dbo.[Книга_Тема]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Книга_Тема] (
        [id_книги] INT NOT NULL,
        [id_темы] INT NOT NULL,
        PRIMARY KEY ([id_книги], [id_темы]),
        FOREIGN KEY ([id_книги]) REFERENCES [dbo].[Книга_образец]([id]),
        FOREIGN KEY ([id_темы]) REFERENCES [dbo].[Тема]([id])
    );
END
