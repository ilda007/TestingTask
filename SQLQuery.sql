create database TestTaskSql

create table dbo.Departament
(
  Id int primary key identity(1, 1) NOT NULL,
  Name nvarchar(100) NOT NULL
)
go

create table dbo.Employee
(
  Id int primary key identity(1, 1) NOT NULL,
	Departament_Id int NOT NULL references Departament (Id),
	Chief_Id int NULL references Employee (Id),
  Name nvarchar(100) NOT NULL,
	Salary Money NOT NULL
)
go

USE [TestTaskSql]
go

INSERT INTO dbo.[Departament]
  ([Departament].[Name])
VALUES
  ('Департамент разработки ПО'),
	('Технологический департамент'),
	('Департамент продаж'),
	('Департамент сетевой связи')
go


--Добавляю шефов 
USE [TestTaskSql]

INSERT INTO dbo.[Employee]
  ([Employee].[Departament_Id]
	,[Employee].[Name]
	,[Employee].[Salary])
VALUES
  ((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,'Олег'
	, 70000),
	((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,'Борис'
	, 87000)
go

--Добавляю работников
USE [TestTaskSql]

INSERT INTO dbo.[Employee]
  ([Employee].[Departament_Id]
	,[Employee].[Chief_Id]
	,[Employee].[Name]
	,[Employee].[Salary])
VALUES
  ((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,1
	,'Василий'
	, 99000),
	((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,2
	,'Аркадий'
	, 47000),
	((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,1
	,'Сергей'
	, 50000),
	((SELECT Id FROM dbo.[Departament] WHERE Name = 'Департамент разработки ПО')
	,2
	,'Александр'
	, 99000)
go

--Запрос на выборку
select Name
      ,Salary
			,Chief_Id
  from dbo.Employee as t
	where Chief_Id is not null and salary > (select salary from dbo.Employee where t.Chief_Id = Id)
go