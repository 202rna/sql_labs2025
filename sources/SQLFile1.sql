SELECT @@TRANCOUNT AS 'Количество транзакций', XACT_STATE() AS 'Состояние транзакций' 
rollback transaction


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- потерянные данные --

BEGIN TRANSACTION

UPDATE Автор
SET имя = 'Алена Ивановна'
WHERE id = 1
select * from Автор

COMMIT TRANSACTION

-- грязное чтение --
BEGIN TRANSACTION

UPDATE Автор
SET имя = 'Афанасий Афанасьев'
WHERE id = 1

ROLLBACK TRANSACTION

COMMIT TRANSACTION
------------ READ COMMITTED -------------

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRANSACTION
UPDATE Автор
SET имя = 'Иван Петров'
WHERE id = 1

SELECT * FROM Автор

COMMIT TRANSACTION

--- неповторяющееся чтение ---

BEGIN TRANSACTION

UPDATE Автор
SET имя = 'Иван Петров'
WHERE id = 1

COMMIT

---------- REPEATABLE READ --------------

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

BEGIN TRANSACTION

-- неповторяющееся чтение --
UPDATE Автор
SET имя = 'Серафим Петров'
WHERE id = 1

-- фантом --
COMMIT

INSERT INTO Автор VALUES ('Серафим Петров')

DELETE FROM Автор WHERE id = 42

------------ SERIALIZABLE -------------

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRANSACTION

INSERT INTO Автор VALUES ('Серафим Петров')


COMMIT TRANSACTION