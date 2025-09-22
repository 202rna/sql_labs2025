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
