create database Contractor

--�������� ������� ������������
create table dbo.Contractor
(
  Id int primary key identity(1, 1) NOT NULL,
  Name nvarchar(20) NOT NULL,
  CompanyDay Date NOT NULL,
  LegalAddress nvarchar(100) NOT NULL,
  PostalAddress nvarchar(100) NOT NULL,
)
go

--�������� ������� ���������
create table dbo.ContractorIndividual
(
  Id int primary key identity(1, 1) NOT NULL,
  FirstName nvarchar(20) NOT NULL,
	SecondName nvarchar(20) NOT NULL,
	MiddleName nvarchar(20) NULL,
  DeathMark bit NOT NULL,
  Bankrupt bit NOT NULL,
  BorrowerDeathDate Date NULL,
)
go

--�������� ������� ������
create table dbo.Sale 
(
  Id int primary key identity(1, 1) NOT NULL,
	Name nvarchar(100) NOT NULL,
	ContractorId int NOT NULL references Contractor (Id),
	ContractorIndividualId int NOT NULL references ContractorIndividual (Id)
)
go

create table dbo.Address
(
  Id int primary key identity(1, 1) NOT NULL,
	Name nvarchar(100) NOT NULL,
)
go

USE [Contractor]
go
--������� � ������� ������������
INSERT INTO dbo.Contractor
  (Contractor.Name
  ,Contractor.CompanyDay
  ,Contractor.LegalAddress
  ,Contractor.PostalAddress)
VALUES
  ('���������'
  ,'12-10-03'
  ,'�. ������ ��.������ �.4'
  ,'�. ������ ��.������ �.4'),
	('�������'
  ,'18-6-2000'
  ,'�. ���� ��.������ �.46'
  ,'�. ���� ��.������ �.46'),
	('����������'
  ,'30-1-01'
  ,'�. ������ ��.���������� �.4'
  ,'�. ������ ��.���������� �.4'),
	('������������'
  ,'12-10-21'
  ,'�. ������ ��.������ �.32'
  ,'�. ������ ��.������ �.32'),
	('�������'
  ,'30-11-1999'
  ,'�. ��� ��.��������� �.13'
  ,'�. ��� ��.��������� �.13')
go

USE [Contractor]
go
--������� � ������� ���������
INSERT INTO dbo.ContractorIndividual
  (ContractorIndividualr.FirstName
  ,ContractorIndividual.SecondName
  ,ContractorIndividual.MiddleName
  ,ContractorIndividual.DeathMark
	,ContractorIndividual.Bankrupt
	,ContractorIndividual.BorrowerDeathDate)
VALUES
  ('���������'
  ,'������'
  ,'���������'
	, 1
	, 1
	, '10-02-1837'),
	('������'
  ,'�������'
  ,'�����������'
	, 1
	, 1
	, '26-03-2018'),
	('Ը���'
  ,'�����������'
  ,'����������'
	, 1
	, 0
	, null),
	('���������'
  ,'����'
  ,null
	, 1
	, 1
	, '5-12-1870'),
	('������'
  ,'����'
  ,null
	, 1
	, 1
	, null),
	('���������'
  ,'�����'
  ,'����������'
	, 1
	, 0
	, null)
go

USE [Contractor]
go
--������� � ������� ������������
INSERT INTO dbo.Sale
  (Sale.Name
  ,Sale.ContractorId
  ,Sale.ContractorIndividualId)
VALUES
  ('������ �1'
  ,1
  ,1),
	('������ �2'
  ,1
  ,2),
	('������ �3'
  ,2
  ,3),
	('������ �4'
  ,2
  ,4),
	('������ �5'
  ,3
  ,5),
	('������ �6'
  ,3
  ,6)
go

-- 1 ������
select 
  Sale.Id as 'Id �� ������', 
	Sale.Name as '�������� ������',
	Contractor.Id as 'Id �����������', 
	Contractor.Name as '�������� �����������'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
go

-- 2 ������
select 
  Sale.Id as 'Id �� ������', 
	Sale.Name as '�������� ������',
	Contractor.Id as 'Id �����������', 
	Contractor.Name as '�������� �����������',
	Contractor.LegalAddress as '����� �����������',
  Contractor.PostalAddress as '�������� �����'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
go

--3 ������
select 
  Sale.Id as 'Id �� ������', 
	Sale.Name as '�������� ������',
	Contractor.Id as 'Id �����������', 
	Contractor.Name as '�������� �����������',
	Contractor.LegalAddress as '����� �����������',
  Contractor.PostalAddress as '�������� �����',
	case when ContractorIndividual.DeathMark = 1 then '����'
	     when ContractorIndividual.DeathMark = 0 then '���' end as '������� � ������',
  case when ContractorIndividual.Bankrupt = 1 then '�������'
	     when ContractorIndividual.Bankrupt = 0 then '�� �������' end as '������� � ����������',
	ContractorIndividual.BorrowerDeathDate as '���� ������'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
	join ContractorIndividual on Sale.ContractorIndividualId = ContractorIndividual.Id
go

--4 ������
select 
  Sale.Id as 'Id �� ������', 
	Sale.Name as '�������� ������',
	Contractor.Id as 'Id �����������', 
	Contractor.Name as '�������� �����������',
	Contractor.LegalAddress as '����� �����������',
  Contractor.PostalAddress as '�������� �����',
	case when ContractorIndividual.DeathMark = 1 then '����'
	     when ContractorIndividual.DeathMark = 0 then '���' end as '������� � ������',
  case when ContractorIndividual.Bankrupt = 1 then '�������'
	     when ContractorIndividual.Bankrupt = 0 then '�� �������' end as '������� � ����������',
	ContractorIndividual.BorrowerDeathDate as '���� ������'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
	join ContractorIndividual on Sale.ContractorIndividualId = ContractorIndividual.Id
	where 
    ContractorIndividual.BorrowerDeathDate is null and ContractorIndividual.DeathMark = 1