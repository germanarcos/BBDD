-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 10.0.3              
-- * Generator date: Aug 17 2017              
-- * Generation date: Fri Oct 20 18:58:32 2017 
-- * LUN file: C:\Users\usuario\Desktop\BBDD\Hoja4\Ejercicio1_2.lun 
-- * Schema: SCHEMA/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database SCHEMA;


-- DBSpace Section
-- _______________


-- Tables Section
-- _____________ 

create table Credito (
     Numero numeric(1) not null,
     Limite_de_pago float(1) not null,
     Tipo char(1) not null,
     constraint ID_Credi_Tarje_ID primary key (Numero));

create table Cuentas (
     Numero char(1) not null,
     DNI char(1) not null,
     constraint ID_Cuentas_ID primary key (Numero));

create table Debito (
     Numero numeric(1) not null,
     Limite_de_pago float(1) not null,
     Tipo char(1) not null,
     constraint ID_Debit_Tarje_ID primary key (Numero));

create table Empresa (
     DNI char(1) not null,
     Tamano char(1) not null,
     Sector char(1) not null,
     constraint ID_Empre_Perso_ID primary key (DNI));

create table Persona (
     Direccion char(1) not null,
     DNI char(1) not null,
     Nombre char(1) not null,
     Ciudad char(1) not null,
     Persona_individual char(1),
     Empresa char(1),
     constraint ID_Persona_ID primary key (DNI));

create table Persona_individual (
     DNI char(1) not null,
     Salario char(1) not null,
     constraint ID_Perso_Perso_ID primary key (DNI));

create table Tarjetas_de_credito (
     Fecha_expiracion char(1) not null,
     Numero_1 numeric(1) not null,
     DNI char(1) not null,
     Debito numeric(1),
     Credito numeric(1),
     Numero char(1) not null,
     constraint ID_Tarjetas_de_credito_ID primary key (Numero_1));


-- Constraints Section
-- ___________________ 

alter table Credito add constraint ID_Credi_Tarje_FK
     foreign key (Numero)
     references Tarjetas_de_credito;

alter table Cuentas add constraint REF_Cuent_Perso_FK
     foreign key (DNI)
     references Persona;

alter table Debito add constraint ID_Debit_Tarje_FK
     foreign key (Numero)
     references Tarjetas_de_credito;

alter table Empresa add constraint ID_Empre_Perso_FK
     foreign key (DNI)
     references Persona;

alter table Persona add constraint EXTONE_Persona
     check((Empresa is not null and Persona_individual is null)
           or (Empresa is null and Persona_individual is not null)); 

alter table Persona_individual add constraint ID_Perso_Perso_FK
     foreign key (DNI)
     references Persona;

alter table Tarjetas_de_credito add constraint EXTONE_Tarjetas_de_credito
     check((Credito is not null and Debito is null)
           or (Credito is null and Debito is not null)); 

alter table Tarjetas_de_credito add constraint REF_Tarje_Perso_FK
     foreign key (DNI)
     references Persona;

alter table Tarjetas_de_credito add constraint REF_Tarje_Cuent_FK
     foreign key (Numero)
     references Cuentas;


-- Index Section
-- _____________ 

create unique index ID_Credi_Tarje_IND
     on Credito (Numero);

create unique index ID_Cuentas_IND
     on Cuentas (Numero);

create index REF_Cuent_Perso_IND
     on Cuentas (DNI);

create unique index ID_Debit_Tarje_IND
     on Debito (Numero);

create unique index ID_Empre_Perso_IND
     on Empresa (DNI);

create unique index ID_Persona_IND
     on Persona (DNI);

create unique index ID_Perso_Perso_IND
     on Persona_individual (DNI);

create unique index ID_Tarjetas_de_credito_IND
     on Tarjetas_de_credito (Numero_1);

create index REF_Tarje_Perso_IND
     on Tarjetas_de_credito (DNI);

create index REF_Tarje_Cuent_IND
     on Tarjetas_de_credito (Numero);

