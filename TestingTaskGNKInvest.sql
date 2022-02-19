create database Contractor

--Создание таблицы контрагентов
create table dbo.Contractor
(
  Id int primary key identity(1, 1) NOT NULL,
  Name nvarchar(20) NOT NULL,
  CompanyDay Date NOT NULL,
  LegalAddress nvarchar(100) NOT NULL,
  PostalAddress nvarchar(100) NOT NULL,
)
go

--Создание таблицы заемщиков
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

--Создание таблицы сделок
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
--Вставка в таблицу контрагентов
INSERT INTO dbo.Contractor
  (Contractor.Name
  ,Contractor.CompanyDay
  ,Contractor.LegalAddress
  ,Contractor.PostalAddress)
VALUES
  ('Микрозайм'
  ,'12-10-03'
  ,'г. Ростов ул.Ленина д.4'
  ,'г. Ростов ул.Ленина д.4'),
	('Минутка'
  ,'18-6-2000'
  ,'г. Сочи ул.Ленина д.46'
  ,'г. Сочи ул.Ленина д.46'),
	('Быстрозайм'
  ,'30-1-01'
  ,'г. Ижевск ул.Пушкинская д.4'
  ,'г. Ижевск ул.Пушкинская д.4'),
	('Быстроденьги'
  ,'12-10-21'
  ,'г. Сарпул ул.Первых д.32'
  ,'г. Сарпул ул.Первых д.32'),
	('Выручка'
  ,'30-11-1999'
  ,'г. Уфа ул.Останкина д.13'
  ,'г. Уфа ул.Останкина д.13')
go

USE [Contractor]
go
--Вставка в таблицу заемщиков
INSERT INTO dbo.ContractorIndividual
  (ContractorIndividualr.FirstName
  ,ContractorIndividual.SecondName
  ,ContractorIndividual.MiddleName
  ,ContractorIndividual.DeathMark
	,ContractorIndividual.Bankrupt
	,ContractorIndividual.BorrowerDeathDate)
VALUES
  ('Александр'
  ,'Пушкин'
  ,'Сергеевич'
	, 1
	, 1
	, '10-02-1837'),
	('Сергей'
  ,'Мавроди'
  ,'Пантелеевич'
	, 1
	, 1
	, '26-03-2018'),
	('Фёдор'
  ,'Достоевский'
  ,'Михайлович'
	, 1
	, 0
	, null),
	('Александр'
  ,'Дюма'
  ,null
	, 1
	, 1
	, '5-12-1870'),
	('Виктор'
  ,'Гюго'
  ,null
	, 1
	, 1
	, null),
	('Александр'
  ,'Попов'
  ,'Степанович'
	, 1
	, 0
	, null)
go

USE [Contractor]
go
--Вставка в таблицу контрагентов
INSERT INTO dbo.Sale
  (Sale.Name
  ,Sale.ContractorId
  ,Sale.ContractorIndividualId)
VALUES
  ('Сделка №1'
  ,1
  ,1),
	('Сделка №2'
  ,1
  ,2),
	('Сделка №3'
  ,2
  ,3),
	('Сделка №4'
  ,2
  ,4),
	('Сделка №5'
  ,3
  ,5),
	('Сделка №6'
  ,3
  ,6)
go

-- 1 задача
select 
  Sale.Id as 'Id из сделки', 
	Sale.Name as 'Название сделки',
	Contractor.Id as 'Id контрагента', 
	Contractor.Name as 'Название контрагента'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
go

-- 2 задача
select 
  Sale.Id as 'Id из сделки', 
	Sale.Name as 'Название сделки',
	Contractor.Id as 'Id контрагента', 
	Contractor.Name as 'Название контрагента',
	Contractor.LegalAddress as 'Адрес регистрации',
  Contractor.PostalAddress as 'Почтовый адрес'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
go

--3 задача
select 
  Sale.Id as 'Id из сделки', 
	Sale.Name as 'Название сделки',
	Contractor.Id as 'Id контрагента', 
	Contractor.Name as 'Название контрагента',
	Contractor.LegalAddress as 'Адрес регистрации',
  Contractor.PostalAddress as 'Почтовый адрес',
	case when ContractorIndividual.DeathMark = 1 then 'Умер'
	     when ContractorIndividual.DeathMark = 0 then 'Жив' end as 'Отметка о смерти',
  case when ContractorIndividual.Bankrupt = 1 then 'Банкрот'
	     when ContractorIndividual.Bankrupt = 0 then 'Не банкрот' end as 'Отметка о банкротсве',
	ContractorIndividual.BorrowerDeathDate as 'Дата смерти'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
	join ContractorIndividual on Sale.ContractorIndividualId = ContractorIndividual.Id
go

--4 задача
select 
  Sale.Id as 'Id из сделки', 
	Sale.Name as 'Название сделки',
	Contractor.Id as 'Id контрагента', 
	Contractor.Name as 'Название контрагента',
	Contractor.LegalAddress as 'Адрес регистрации',
  Contractor.PostalAddress as 'Почтовый адрес',
	case when ContractorIndividual.DeathMark = 1 then 'Умер'
	     when ContractorIndividual.DeathMark = 0 then 'Жив' end as 'Отметка о смерти',
  case when ContractorIndividual.Bankrupt = 1 then 'Банкрот'
	     when ContractorIndividual.Bankrupt = 0 then 'Не банкрот' end as 'Отметка о банкротсве',
	ContractorIndividual.BorrowerDeathDate as 'Дата смерти'
from
  Sale 
	join Contractor on Sale.ContractorId = Contractor.Id
	join ContractorIndividual on Sale.ContractorIndividualId = ContractorIndividual.Id
	where 
    ContractorIndividual.BorrowerDeathDate is null and ContractorIndividual.DeathMark = 1