--- Задание №1 ---
USE bookshop;

SET IMPLICIT_TRANSACTIONS ON

INSERT INTO [Тема] VALUES ('Программирование')
SELECT * FROM [Тема]


ROLLBACK
SELECT * FROM [Тема]


INSERT INTO [Тема] VALUES ('Программирование')
SELECT * FROM [Тема]
COMMIT TRANSACTION

SELECT @@TRANCOUNT AS 'Количество транзакций', XACT_STATE() AS 'Состояние транзакций' 

SET IMPLICIT_TRANSACTIONS OFF

------------------ Задание №2 ----------------------

--------READ UNCOMMITTED------------
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;


-- 1. Грязное чтение --
BEGIN TRANSACTION

UPDATE Автор
SET имя = 'Олег Петров'
WHERE id = 1

COMMIT TRANSACTION

-- грязное чтение --

BEGIN TRANSACTION

SELECT * FROM Автор WHERE id = 1


-----------READ COMMITTED------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--- неповторяющееся чтение ---

BEGIN TRANSACTION

SELECT * FROM Автор WHERE имя LIKE('%Петров')

-- повторно прочитываем --

SELECT * FROM Автор WHERE имя LIKE('%Петров')

COMMIT TRANSACTION


---------- REPEATABLE READ --------------

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ


BEGIN TRANSACTION

SELECT * FROM Автор WHERE имя LIKE('%Петров')

COMMIT
-- повторно прочитываем --

SELECT * FROM Автор WHERE имя LIKE('%Петров')

COMMIT TRANSACTION


------------ SERIALIZABLE -------------

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRANSACTION

SELECT * FROM Автор WHERE имя LIKE('%Петров')

COMMIT TRANSACTION

-- повторно прочитываем --

SELECT * FROM Автор WHERE имя LIKE('%Петров')

COMMIT TRANSACTION