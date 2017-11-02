-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 10.0.3              
-- * Generator date: Aug 17 2017              
-- * Generation date: Fri Oct 20 19:00:08 2017 
-- * LUN file: C:\Users\usuario\Desktop\BBDD\Hoja4\Ejercicio3_2.lun 
-- * Schema: SCHEMA/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database SCHEMA;


-- DBSpace Section
-- _______________


-- Tables Section
-- _____________ 

create table Automovil (
     ID_Aut -- Sequence attribute not implemented -- not null,
     Nº_Bastidor char(1) not null,
     ID_Con numeric(10) not null,
     Modelo char(1) not null,
     Marca char(1) not null,
     Precio char(1) not null,
     Descuento char(1) not null,
     Datos_tecnicos char(1) not null,
     constraint ID_Automovil_ID primary key (ID_Aut),
     constraint SID_Automovil_ID unique (Nº_Bastidor),
     constraint SID_Autom_Conju_ID unique (ID_Con));

create table Concesionario (
     ID_Con -- Sequence attribute not implemented -- not null,
     ID_Loc numeric(10) not null,
     constraint ID_Concesionario_ID primary key (ID_Con),
     constraint SID_Conce_Local_ID unique (ID_Loc));

create table Conjunto_de_serie (
     ID_Con -- Sequence attribute not implemented -- not null,
     (Debil) char(1) not null,
     Tipo char(1) not null,
     constraint ID_Conjunto_de_serie_ID primary key (ID_Con));

create table Equipamiento (
     Tipo char(1) not null,
     Precio char(1) not null,
     ID_Aut numeric(10) not null,
     constraint ID_Equipamiento_ID primary key (Tipo));

create table Local (
     ID_Loc -- Sequence attribute not implemented -- not null,
     Servicio_oficial numeric(10),
     Concesionario numeric(10),
     ID_Aut numeric(10) not null,
     constraint ID_Local_ID primary key (ID_Loc));

create table Servicio_oficial (
     ID_Loc numeric(10) not null,
     Nombre char(1) not null,
     Domicilio char(1) not null,
     NIF char(1) not null,
     ID_Con numeric(10) not null,
     constraint ID_Servi_Local_ID primary key (ID_Loc));

create table Vende (
     ID_Aut numeric(10) not null,
     ID_Loc numeric(10) not null,
     Precio_cobrado char(1) not null,
     Modo_pago char(1) not null,
     constraint ID_Vende_ID primary key (ID_Loc, ID_Aut, ),
     constraint SID_Vende_Local_ID unique (ID_Loc),
     constraint SID_Vende_Autom_ID unique (ID_Aut));

create table Vendedor (
     Nombre char(1) not null,
     NIF char(1) not null,
     Domicilio char(1) not null);


-- Constraints Section
-- ___________________ 

alter table Automovil add constraint ID_Automovil_CHK
     check(exists(select * from Local
                  where Local.ID_Aut = ID_Aut)); 

alter table Automovil add constraint ID_Automovil_CHK
     check(exists(select * from Vende
                  where Vende.ID_Aut = ID_Aut)); 

alter table Automovil add constraint SID_Autom_Conju_FK
     foreign key (ID_Con)
     references Conjunto_de_serie;

alter table Concesionario add constraint SID_Conce_Local_FK
     foreign key (ID_Loc)
     references Local;

alter table Conjunto_de_serie add constraint ID_Conjunto_de_serie_CHK
     check(exists(select * from Automovil
                  where Automovil.ID_Con = ID_Con)); 

alter table Conjunto_de_serie add constraint EQU_Conju_Equip_FK
     foreign key (Tipo)
     references Equipamiento;

alter table Equipamiento add constraint ID_Equipamiento_CHK
     check(exists(select * from Conjunto_de_serie
                  where Conjunto_de_serie.Tipo = Tipo)); 

alter table Equipamiento add constraint REF_Equip_Autom_FK
     foreign key (ID_Aut)
     references Automovil;

alter table Local add constraint ID_Local_CHK
     check(exists(select * from Vende
                  where Vende.ID_Loc = ID_Loc)); 

alter table Local add constraint EXTONE_Local
     check((Concesionario is not null and Servicio_oficial is null)
           or (Concesionario is null and Servicio_oficial is not null)); 

alter table Local add constraint EQU_Local_Autom_FK
     foreign key (ID_Aut)
     references Automovil;

alter table Servicio_oficial add constraint ID_Servi_Local_FK
     foreign key (ID_Loc)
     references Local;

alter table Servicio_oficial add constraint REF_Servi_Conce_FK
     foreign key (ID_Con)
     references Concesionario;

alter table Vende add constraint SID_Vende_Local_FK
     foreign key (ID_Loc)
     references Local;

alter table Vende add constraint SID_Vende_Autom_FK
     foreign key (ID_Aut)
     references Automovil;


-- Index Section
-- _____________ 

create unique index ID_Automovil_IND
     on Automovil (ID_Aut);

create unique index SID_Automovil_IND
     on Automovil (Nº_Bastidor);

create unique index SID_Autom_Conju_IND
     on Automovil (ID_Con);

create unique index ID_Concesionario_IND
     on Concesionario (ID_Con);

create unique index SID_Conce_Local_IND
     on Concesionario (ID_Loc);

create unique index ID_Conjunto_de_serie_IND
     on Conjunto_de_serie (ID_Con);

create index EQU_Conju_Equip_IND
     on Conjunto_de_serie (Tipo);

create unique index ID_Equipamiento_IND
     on Equipamiento (Tipo);

create index REF_Equip_Autom_IND
     on Equipamiento (ID_Aut);

create unique index ID_Local_IND
     on Local (ID_Loc);

create index EQU_Local_Autom_IND
     on Local (ID_Aut);

create unique index ID_Servi_Local_IND
     on Servicio_oficial (ID_Loc);

create index REF_Servi_Conce_IND
     on Servicio_oficial (ID_Con);

create unique index ID_Vende_IND
     on Vende (ID_Loc, ID_Aut, );

create unique index SID_Vende_Autom_IND
     on Vende (ID_Aut);

