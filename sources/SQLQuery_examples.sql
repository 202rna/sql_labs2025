USE bookshop;

SELECT 
	*
FROM
	[dbo].[������������]
ORDER BY
	[��������] ASC, [�������] DESC


SELECT
	*
FROM 
	[dbo].[����������]
WHERE
	[���] = '��������� ����� ��������'



SELECT
	*
FROM 
	[dbo].[�����_�����]
WHERE
	[����_�����������] > '2024-01-01'



SELECT
	*
FROM
	[dbo].[�����_�����]

select * from [�����]
select * from [�����_�������]
insert into [�����](id, ���) values 
(11, '������� ������'),
(12, '������ ������')

insert into [�����_�������](id, ��������) values
(11, '������������ ����')

select * from [�����_�����]

insert into [�����_�����]([id_������],[id_�����]) values 
(11,11), (12,11)

SELECT
	b.[��������],
	COUNT([id_�����]) as '������� ������� � �����'
FROM
	[dbo].[�����_�����] a
	INNER JOIN [dbo].[�����_�������] b ON
		a.id_����� = b.id
GROUP BY
	[id_�����], b.[��������]


SELECT
	MAX([�����_�����������]) as '������� ����������� ��������� � ���� ���� �����������'
FROM
	[dbo].[�����_�����]
GROUP BY
	[����_�����������]


INSERT INTO [dbo].[�����_�����]([id],[id_������������],[����_�����������],[����������_����],[����_�������],[�����_�����������])
VALUES (11, 10, '2023-11-15', 600, 700, 1000)
SELECT * FROM [dbo].[�����_�����]

SELECT
	[������], [����],
	COUNT(*)
FROM
	[dbo].[�����]
GROUP BY CUBE([������], [����])

SELECT * FROM [dbo].[����������]


SELECT
	[���]
FROM
	[dbo].[����������]
WHERE 
	[���] NOT LIKE '������%'


SELECT
	���, �����, ������, ����
FROM
	[dbo].[����������] c, [dbo].[�����] o
WHERE
	c.id = o.id_����������

SELECT
	��������, �������, �����, ����_�����������, �����_�����������,
	����������_����
FROM
	[dbo].[������������] p, [dbo].[�����_�����] c
WHERE
	c.id_������������ = p.id


SELECT
	���, �����, ������, ����
FROM
	[dbo].[����������] c
	INNER JOIN [dbo].[�����] o ON c.id = o.id_����������


SELECT
	��������, �������, �����, ����_�����������, �����_�����������,
	����������_����
FROM
	[dbo].[������������] p
	INNER JOIN [dbo].[�����_�����] c ON c.id_������������ = p.id



SELECT * FROM [dbo].[����������]

SELECT * FROM [dbo].[�����]

INSERT INTO [dbo].[����������](id, [�����], [���]) VALUES
(11, '���������, ��������� 24', '�������� ������ ����������'),
(12, '���������, �������� 36', '������ ���� ����������');

SELECT
	*
FROM
	[dbo].[����������] C
	LEFT JOIN [dbo].[�����] O ON C.id = O.id_����������


INSERT INTO [dbo].[������������](id, [�����], [��������], [�������]) VALUES
(11, '�������, ��. �������� 94', '����������', '8800222235'),
(12, '������, ��. ������� 69', '����������', '8900333325')


SELECT * FROM [dbo].[������������]

SELECT
	*
FROM
	[dbo].[������������] p
	LEFT JOIN [dbo].[�����_�����] c ON c.id_������������ = p.id


SELECT
	*
FROM
	[dbo].[�����] O
	RIGHT JOIN [dbo].[����������] C ON C.id = O.id_����������


SELECT
	*
FROM
	[dbo].[�����_�����] c
	RIGHT JOIN [dbo].[������������] p ON c.id_������������ = p.id


SELECT * FROM [dbo].[�����_����]

SELECT
	J.��������,
	COUNT(BJ.[id_�����]) AS '������� ���� ����� ������'
FROM
	[dbo].[�����_����] BJ
	INNER JOIN [dbo].[����] J ON BJ.id_����� = J.id 
GROUP BY
	BJ.id_�����, J.��������


SELECT * FROM [dbo].[�����_�����]

SELECT
	IZ.[��������],
	SUM(T.[�����_�����������]) AS '������� ����������� ����� ����������� ������� ������������'
FROM
	[dbo].[�����_�����] T
	INNER JOIN [dbo].[������������] IZ ON T.id_������������ = IZ.id
GROUP BY
	T.id_������������, IZ.[��������]


SELECT * FROM [dbo].[�����_�����]

SELECT 
	[id_�����] as '� ����� ������ 1 ������'
FROM 
	[dbo].[�����_�����]
GROUP BY
	[id_�����]
HAVING
	count(*) > 1

select * from [dbo].[�����_�����]

SELECT
	[����_�����������] as '��� ����� ��������� ����� 1000 ���.'
FROM
	[dbo].[�����_�����]
GROUP BY
	[����_�����������]
HAVING
	sum([�����_�����������]) > 1000


SELECT * FROM [dbo].[�����]

INSERT INTO [dbo].[�����](id,[���]) VALUES (13,'���������� ����������')

DELETE FROM [dbo].[�����]
WHERE id = 13


SELECT
	A.id
FROM
	[dbo].[�����] A
WHERE EXISTS(
	SELECT 1
	FROM [dbo].[�����_�����] BA
	WHERE BA.id_������ IN (A.id)
	)


SELECT DISTINCT BA.id_������
FROM [dbo].[�����_�����] BA
WHERE BA.id_����� IN (
    SELECT BA2.id_�����
    FROM [dbo].[�����_�����] BA2
    WHERE BA2.id_������ != BA.id_������
);


SELECT DISTINCT A.id, A.���
FROM [dbo].[�����] A
WHERE EXISTS (
    SELECT 1
    FROM [dbo].[�����_�����] BA
    WHERE BA.id_������ = A.id
    AND NOT EXISTS (
        SELECT 1
        FROM [dbo].[�����_�����] BA1
        WHERE BA1.id_����� = BA.id_�����
        AND BA1.id_������ != BA.id_������
    )
)

GO

CREATE VIEW CountBooksPublishers AS
SELECT
	IZ.[��������],
	SUM(T.[�����_�����������]) AS '������� ����������� ����� ����������� ������� ������������'
FROM
	[dbo].[�����_�����] T
	INNER JOIN [dbo].[������������] IZ ON T.id_������������ = IZ.id
GROUP BY
	T.id_������������, IZ.[��������]


GO

CREATE VIEW AuthorWhoHasSoauthor AS
SELECT DISTINCT BA.id_������
FROM [dbo].[�����_�����] BA
WHERE BA.id_����� IN (
    SELECT BA2.id_�����
    FROM [dbo].[�����_�����] BA2
    WHERE BA2.id_������ != BA.id_������
);


go

select * from AuthorWhoHasSoauthor

go

with cte_query as (
select [id_������]
from [dbo].[�����_�����]
)

select * 
from cte_query

go 

with cte_query2 as (
select [��������]
from [dbo].[������������]
)

select * 
from cte_query2
where [��������] = '���'

go

select [id_�����], [id_������],
row_number() over (order by [id_������] desc),
rank() over (order by [id_������] desc),
dense_rank() over (order by [id_������] desc)
from [dbo].[�����_�����];

select * from [dbo].[�����_�����]


SELECT [id_�����] 
FROM [dbo].[�����_����] 
WHERE [id_�����] = (SELECT [id] FROM [dbo].[����] WHERE [��������] = '����������')
INTERSECT
SELECT [id_�����]
FROM [dbo].[�����_����] 
WHERE [id_����] = (SELECT [id] FROM [dbo].[����] WHERE [��������] = '�����������');


SELECT [���] AS [���] 
FROM [dbo].[�����]

UNION ALL

SELECT [���] AS [���]
FROM [dbo].[����������];


SELECT [���] FROM [dbo].[�����]
EXCEPT
SELECT A.[���] 
FROM [dbo].[�����] A
JOIN [dbo].[�����_�����] KA ON A.[id] = KA.[id_������]
JOIN [dbo].[�����_����] KG ON KA.[id_�����] = KG.[id_�����]
JOIN [dbo].[����] G ON KG.[id_�����] = G.[id]
WHERE G.[��������] = '��������'
ORDER BY [���];


SELECT 
    CASE WHEN [������] = 1 THEN '��������' ELSE '�� ��������' END AS [������ ������],
    COUNT(*) AS [���������� �������],
    SUM(T.[����_�������]) AS [����� ����� ������]
FROM [dbo].[�����] Z
JOIN [dbo].[�����_���������] KE ON Z.[id] = KE.[id_������]
JOIN [dbo].[�����_�����] T ON KE.[id_������_�����] = T.[id]
GROUP BY [������];


SELECT * FROM (
    SELECT [��������] AS JName, COUNT(*) AS Count
    FROM [dbo].[�����_����] BJ
	JOIN [dbo].[����] J ON BJ.id_����� = J.id
    GROUP BY BJ.id_�����, J.��������
) AS SourceTable
PIVOT (
    SUM(Count) FOR JName IN ([����������], [��������], [�����],
	[�����], [������], [���������], [�����], [�������], [�������],
	[�������])
) AS PivotTable;


SELECT JName, Count
FROM (
    SELECT * FROM (
        SELECT [��������] AS JName, COUNT(*) AS Count
        FROM [dbo].[�����_����] BJ
        JOIN [dbo].[����] J ON BJ.id_����� = J.id
        GROUP BY BJ.id_�����, J.��������
    ) AS SourceTable
    PIVOT (
        SUM(Count) FOR JName IN ([����������], [��������], [�����],
        [�����], [������], [���������], [�����], [�������], [�������],
        [�������])
    ) AS PivotTable
) AS P
UNPIVOT (
    Count FOR JName IN ([����������], [��������], [�����],
    [�����], [������], [���������], [�����], [�������], [�������],
    [�������])
) AS UnpivotTable;


select * from [dbo].[����]