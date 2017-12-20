      -- *********************************************
      -- * Standard SQL generation                   
      -- *--------------------------------------------
      -- * DB-MAIN version: 9.3.0              
      -- * Generator date: Feb 16 2016              
      -- * Generation date: Wed Dec 13 18:24:23 2017 
      -- * LUN file: D:\ies Santiago Hernández\2017-2018\Bases de Datos\tema06\pedido_ORACLE.lun 
      -- * Schema: MLD/SQL 
      -- ********************************************* 
      
      
      -- Database Section
      -- ________________ 
      
      create database MLD;
      
      
      -- DBSpace Section
      -- _______________
      
      
      -- Tables Section
      -- _____________ 
      
      create table Pedido (
           clave char(5) not null,
           fecha date not null,
           total numeric(12,2) not null,
           codigo char(5) not null,
           constraint ID_Pedido_ID primary key (clave));
      
      create table Linea (
           clave char(5) not null,
           num char(3) not null,
           articulo char(10) not null,
           cantidad numeric(10) not null,
           precio numeric(7,2) not null,
           constraint ID_Linea_ID primary key (clave, num));
      
      create table empresa (
           codigo char(5) not null,
           nif char(9) not null,
           director char(20) not null,
           constraint ID_empre_clien_ID primary key (codigo));
      
      create table Particular (
           codigo char(5) not null,
           dni char(9) not null,
           fecha_nacimiento date not null,
           constraint ID_Parti_clien_ID primary key (codigo));
      
      create table cliente (
           codigo char(5) not null,
           nombre char(25) not null,
           direccion char(70) not null,
           Particular char(5),
           empresa char(5),
           constraint ID_cliente_ID primary key (codigo));
      
      create table telefono (
           codigo char(5) not null,
           telefono char(9) not null,
           constraint ID_telefono_ID primary key (codigo, telefono));
      
      
      -- Constraints Section
      -- ___________________ 
      
      alter table Pedido add constraint REF_Pedid_clien_FK
           foreign key (codigo)
           references cliente;
      
      alter table Linea add constraint REF_Linea_Pedid
           foreign key (clave)
           references Pedido;
      
      alter table empresa add constraint ID_empre_clien_FK
           foreign key (codigo)
           references cliente;
      
      alter table Particular add constraint ID_Parti_clien_FK
           foreign key (codigo)
           references cliente;
      
      alter table cliente add constraint ID_cliente_CHK
           check(exists(select * from telefono
                        where telefono.codigo = codigo)); 
      
      alter table cliente add constraint EXTONE_cliente
           check((empresa is not null and Particular is null)
                 or (empresa is null and Particular is not null)); 
      
      alter table telefono add constraint EQU_telef_clien
           foreign key (codigo)
           references cliente;
      
      
      -- Index Section
      -- _____________ 
      
      create unique index ID_Pedido_IND
           on Pedido (clave);
      
      create index REF_Pedid_clien_IND
           on Pedido (codigo);
      
      create unique index ID_Linea_IND
           on Linea (clave, num);
      
      create unique index ID_empre_clien_IND
           on empresa (codigo);
      
      create unique index ID_Parti_clien_IND
           on Particular (codigo);
      
      create unique index ID_cliente_IND
           on cliente (codigo);
      
      create unique index ID_telefono_IND
           on telefono (codigo, telefono);
      
