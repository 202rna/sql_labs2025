USE bookshop;

CREATE ROLE Rukovoditel;

GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Автор] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Жанр] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Заказ] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Издательство] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книга_Автор] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книга_Жанр] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книга_образец] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книга_Тема] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Книга_экземпляр] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Тема] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Тираж_книги] TO Rukovoditel WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Покупатель] TO Rukovoditel;

GRANT EXECUTE ON [dbo].[GetLossReport] TO Rukovoditel;
GRANT EXECUTE ON [dbo].[GetTotalBook] TO Rukovoditel;
GRANT EXECUTE ON [dbo].[LossEditionCount] TO Rukovoditel;
GRANT EXECUTE ON [dbo].[most_popular_book] TO Rukovoditel;
GRANT EXECUTE ON [dbo].[theme_books] TO Rukovoditel;

CREATE ROLE Sotrudnik;

GRANT EXECUTE ON [dbo].[GetTotalBook] TO Sotrudnik;
GRANT EXECUTE ON [dbo].[theme_books] TO Sotrudnik;

GRANT SELECT, INSERT, DELETE ON [dbo].[Автор] TO Sotrudnik;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Жанр] TO Sotrudnik;
GRANT SELECT ON [dbo].[Заказ] TO Sotrudnik;
GRANT SELECT, INSERT ON [dbo].[Издательство] TO Sotrudnik;
GRANT SELECT, INSERT, DELETE ON [dbo].[Книга_Автор] TO Sotrudnik;
GRANT SELECT, INSERT, DELETE ON [dbo].[Книга_Жанр] TO Sotrudnik;
GRANT SELECT, INSERT ON [dbo].[Книга_образец] TO Sotrudnik;
GRANT SELECT, INSERT ON [dbo].[Книга_Тема] TO Sotrudnik;
GRANT SELECT ON [dbo].[Книга_экземпляр] TO Sotrudnik;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Тема] TO Sotrudnik;
GRANT SELECT, INSERT, UPDATE, DELETE ON [dbo].[Тираж_книги] TO Sotrudnik;
GRANT SELECT, INSERT ON [dbo].[Покупатель] TO Sotrudnik;



ALTER TABLE [dbo].[Покупатель]
ALTER COLUMN [ФИО] ADD MASKED WITH (FUNCTION = 'partial(2,"*",0)')

ALTER TABLE [dbo].[Покупатель]
ALTER COLUMN [адрес] ADD MASKED WITH (FUNCTION = 'partial(3,"*",0)')

GRANT UNMASK TO Rukovoditel;