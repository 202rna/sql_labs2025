USE [bookshop];

-- ������� �����
IF OBJECT_ID('dbo.[�����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [���] NVARCHAR(255) NOT NULL
    );
END

-- ������� ����
IF OBJECT_ID('dbo.[����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[����] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [��������] NVARCHAR(255) NOT NULL
    );
END

-- ������� ����
IF OBJECT_ID('dbo.[����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[����] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [��������] NVARCHAR(255) NOT NULL
    );
END

-- ������� �����_�������
IF OBJECT_ID('dbo.[�����_�������]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_�������] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [��������] NVARCHAR(255) NOT NULL
    );
END

-- ������� ������������
IF OBJECT_ID('dbo.[������������]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[������������] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [��������] NVARCHAR(255) NOT NULL,
        [�������] NVARCHAR(11),
        [�����] NVARCHAR(255)
    );
END

-- ������� ����������
IF OBJECT_ID('dbo.[����������]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[����������] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [���] NVARCHAR(255) NOT NULL,
        [�����] NVARCHAR(255)
    );
END

-- ������� �����
IF OBJECT_ID('dbo.[�����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [������] INT NOT NULL DEFAULT(0),
        [����] DATE NOT NULL,
        [id_����������] INT,
        FOREIGN KEY ([id_����������]) REFERENCES [dbo].[����������]([id]) ON DELETE CASCADE,
        CHECK ([������] > -1 AND [������] < 3)
    );
END

-- ������� �����_�����
IF OBJECT_ID('dbo.[�����_�����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_�����] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [����_�����������] DATE NOT NULL,
        [����_�������] DATE NOT NULL,
        [����_�������] DECIMAL(10,2) NOT NULL,
        [�����_�����������] INT NOT NULL,
        [����������_����] DECIMAL(10,2) NOT NULL,
        [id_������������] INT NOT NULL,
        FOREIGN KEY ([id_������������]) REFERENCES [dbo].[������������]([id]) ON DELETE CASCADE,
        CHECK ([�����_�����������] >= 0 AND [����������_����] >= 0 AND [����_�������] >= 0 
              AND [����_�����������] >= [����_�������])
    );
END

-- ������� �����_���������
IF OBJECT_ID('dbo.[�����_���������]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_���������] (
        [����] INT IDENTITY(1,1) PRIMARY KEY,
        [id_������_�����] INT NOT NULL,
        [id_�������] INT NOT NULL,
        [id_������] INT NULL,  -- ������ NULL, ����� ��������� ��� ���� ��� ������ (� �������)
        FOREIGN KEY ([id_������_�����]) REFERENCES [dbo].[�����_�����]([id]) ON DELETE CASCADE,
        FOREIGN KEY ([id_�������]) REFERENCES [dbo].[�����_�������]([id]) ON DELETE CASCADE,
        FOREIGN KEY ([id_������]) REFERENCES [dbo].[�����]([id]) ON DELETE SET NULL  -- SET NULL ������ CASCADE, ���� ����� �����
    );
END

-- ������� �����_����� (���������)
IF OBJECT_ID('dbo.[�����_�����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_�����] (
        [id_�����] INT NOT NULL,
        [id_������] INT NOT NULL,
        PRIMARY KEY ([id_������], [id_�����]),
        FOREIGN KEY ([id_������]) REFERENCES [dbo].[�����]([id]),
        FOREIGN KEY ([id_�����]) REFERENCES [dbo].[�����_�������]([id])
    );
END

-- ������� �����_���� (���������)
IF OBJECT_ID('dbo.[�����_����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_����] (
        [id_�����] INT NOT NULL,
        [id_�����] INT NOT NULL,
        PRIMARY KEY ([id_�����], [id_�����]),
        FOREIGN KEY ([id_�����]) REFERENCES [dbo].[�����_�������]([id]),
        FOREIGN KEY ([id_�����]) REFERENCES [dbo].[����]([id])
    );
END

-- ������� �����_���� (���������)
IF OBJECT_ID('dbo.[�����_����]', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[�����_����] (
        [id_�����] INT NOT NULL,
        [id_����] INT NOT NULL,
        PRIMARY KEY ([id_�����], [id_����]),
        FOREIGN KEY ([id_�����]) REFERENCES [dbo].[�����_�������]([id]),
        FOREIGN KEY ([id_����]) REFERENCES [dbo].[����]([id])
    );
END
