USE bookshop;
CREATE TABLE [�����] (
	id		INT Not Null PRIMARY KEY,
	[���]	NVARCHAR(255) Not Null
);

CREATE TABLE [����] (
	id			INT Not Null PRIMARY KEY,
	[��������]	NVARCHAR(255) Not Null
);

CREATE TABLE [����] (
	id			INT Not Null PRIMARY KEY,
	[��������]	NVARCHAR(255) Not Null
);

CREATE TABLE [�����_�������] (
	id			INT Not Null PRIMARY KEY,
	[��������]	NVARCHAR(255) Not Null
);

CREATE TABLE [������������] (
	id			INT Not Null PRIMARY KEY,
	[��������]	NVARCHAR(255) Not Null,
	[�������]	NVARCHAR(11),
	[�����]		NVARCHAR(255)
);

CREATE TABLE [����������] (
	id		INT Not Null PRIMARY KEY,
	[���]	NVARCHAR(255) Not Null,
	[�����] NVARCHAR(255)
);

CREATE TABLE [�����] (
	id				INT Not Null PRIMARY KEY,
	[������]		INT Not Null DEFAULT(0),
	[����]			DATE Not Null,
	[id_����������] INT,
	FOREIGN KEY ([id_����������]) REFERENCES [����������]([id]) ON DELETE CASCADE,
	CHECK ([������] > -1 AND [������] < 3)
);

CREATE TABLE [�����_�����] (
	id					INT Not Null PRIMARY KEY,
	[����_�����������]	DATE Not Null,
	[����]				DATE Not Null,
	[����_�������]		DECIMAL Not Null,
	[�����_�����������] INT Not Null,
	[����������_����]	DECIMAL Not Null,
	[id_������������]	INT Not Null,
	FOREIGN KEY ([id_������������]) REFERENCES [������������]([id]) ON DELETE CASCADE,
	CHECK ([�����_�����������] >= 0 and [����������_����] >= 0 and [����_�������] >= 0)
);

CREATE TABLE [�����_���������] (
	[����]				INT Not Null PRIMARY KEY,
	[id_������_�����]	INT Not Null,
	[id_�������]		INT Not Null,
	[id_������]			INT Not Null,
	FOREIGN KEY ([id_������_�����]) REFERENCES [�����_�����]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([id_�������]) REFERENCES [�����_�������]([id]) ON DELETE CASCADE,
	FOREIGN KEY ([id_������]) REFERENCES [�����]([id]) ON DELETE CASCADE
);

CREATE TABLE [�����_�����] (
    [id_�����]	INT Not Null,
    [id_������] INT Not Null,
	PRIMARY KEY ([id_������], [id_�����]),
    FOREIGN KEY ([id_������]) REFERENCES [�����]([id]),
    FOREIGN KEY ([id_�����]) REFERENCES [�����_�������]([id])
);

CREATE TABLE [�����_����] (
	[id_�����] INT Not Null,
	[id_�����] INT Not Null,
	PRIMARY KEY ([id_�����], [id_�����]),
	FOREIGN KEY ([id_�����]) REFERENCES [�����_�������]([id]),
	FOREIGN KEY ([id_�����]) REFERENCES [����]([id])
);

CREATE TABLE [�����_����] (
	[id_�����]	INT Not Null,
	[id_����]	INT Not Null,
	PRIMARY KEY ([id_�����], [id_����]),
	FOREIGN KEY ([id_�����]) REFERENCES [�����_�������]([id]),
	FOREIGN KEY ([id_����]) REFERENCES [����]([id])
);
