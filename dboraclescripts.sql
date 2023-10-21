--El presente script tiene los scripts de los objetos de la base de datos en oracle

--crear usuario billetera_abel y asignar privilegios
CREATE USER billetera_abel IDENTIFIED BY Micontrasenia2023 DEFAULT TABLESPACE data;
GRANT CREATE SESSION TO billetera_abel;
ALTER USER billetera_abel QUOTA 50M ON data;
GRANT CREATE TABLE TO billetera_abel;
GRANT CREATE SEQUENCE TO billetera_abel;

--Crear las tablas
CREATE TABLE billetera_abel.type_of_transactions (
    tpe_id NUMBER(10),
    tpe_name VARCHAR2(45) NOT NULL,
    CONSTRAINT type_of_transactions_pk PRIMARY KEY (tpe_id)
) TABLESPACE data;

CREATE TABLE billetera_abel.users (
    usr_id        NUMBER(10),
    usr_name      VARCHAR2(45) NOT NULL,
    usr_last_name VARCHAR2(45) NOT NULL,
    usr_email     VARCHAR2(45) NOT NULL,
    usr_password  VARCHAR2(45) NOT NULL,
    CONSTRAINT users_pk PRIMARY KEY (usr_id)
) TABLESPACE data;

CREATE table billetera_abel.wallets (
    wal_id NUMBER(10),
    usr_id NUMBER(10) NOT NULL,
    CONSTRAINT wallets_pk PRIMARY KEY (wal_id),
    CONSTRAINT wallets_users_fk FOREIGN KEY ( usr_id ) REFERENCES billetera_abel.users ( usr_id )
) TABLESPACE data;

 CREATE TABLE billetera_abel.companies (
    cpn_id              NUMBER(10),
    cpn_holder_name     VARCHAR2(45) NOT NULL,
    cpn_number          VARCHAR2(20),
    cpn_company_name    VARCHAR2(45) NOT NULL,
    cpn_api_key         VARCHAR2(45) NOT NULL,
    cpn_expiration_date DATE NOT NULL,
    wal_id              NUMBER(10) NOT NULL,
    CONSTRAINT companies_pk PRIMARY KEY (cpn_id),
    CONSTRAINT companies_wallets_fk FOREIGN KEY ( wal_id ) REFERENCES billetera_abel.wallets ( wal_id )
) TABLESPACE data;

CREATE TABLE billetera_abel.contacts (
    con_id    NUMBER(10),
    con_name  VARCHAR2(45) NOT NULL,
    con_email VARCHAR2(45) NOT NULL,
    wal_id    NUMBER(10) NOT NULL,
    CONSTRAINT contacts_pk PRIMARY KEY (con_id),
    CONSTRAINT contacts_wallets_fk FOREIGN KEY ( wal_id ) REFERENCES billetera_abel.wallets ( wal_id )
) TABLESPACE data;

CREATE table billetera_abel.transactions (
    tra_id NUMBER(10),
    tra_amount NUMBER(11) NOT NULL,
    tra_signe VARCHAR2(45) NOT NULL,
    tra_date DATE NOT NULL,
    tra_description VARCHAR2(45) NOT NULL,
    tra_tracking VARCHAR2(45) NOT NULL,
    tpe_id NUMBER(10) NOT NULL,
    wal_id NUMBER(10) NOT NULL,
    cpn_id NUMBER(10),
    CONSTRAINT transactions_pk PRIMARY KEY (tra_id),
    CONSTRAINT transactions_companies_fk FOREIGN KEY ( cpn_id ) REFERENCES billetera_abel.companies ( cpn_id ),
    CONSTRAINT transactions_type_of_transactions_fk FOREIGN KEY ( tpe_id ) REFERENCES billetera_abel.type_of_transactions ( tpe_id ), 
    CONSTRAINT transactions_wallets_fk FOREIGN KEY ( wal_id ) REFERENCES billetera_abel.wallets ( wal_id )
) TABLESPACE data;


--Insertar los datos
--Insertar datos en la tabla de type of transactions
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(1, 'CASH');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(2, 'CARD');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(3, 'INVOICE');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(4, 'TRANSFER');
commit;
SELECT COUNT(*) as from billetera_abel.type_of_transactions;


--Insertar datos en la tabla de users
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(1, 'Abel','Mamani', 'abel@gmail.com', '1234567891');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(2, 'Cristina','Mamani', 'cristian@gmail.com', '1234567892');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(3, 'Julieta','Villagra', 'julieta@gmail.com', '1234567893');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(4, 'Daniela','Triador', 'daniela@gmail.com', '1234567894');
commit;
SELECT COUNT(*) as from billetera_abel.users;


--Insertar datos en la tabla wallets
insert into billetera_abel.wallets (wal_id, usr_id) values (1, 1);
insert into billetera_abel.wallets (wal_id, usr_id) values (2, 2);
insert into billetera_abel.wallets (wal_id, usr_id) values (3, 3);
insert into billetera_abel.wallets (wal_id, usr_id) values (4, 4);
commit;
SELECT COUNT(*) as from billetera_abel.wallets;


--Insertar datos en la tabla companies
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (1, 'ABEL MAMANI', '12345678911', 'Visa', 'api visa', sysdate, 1);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (2, 'ABEL MAMANI', '12345678912', 'Mastercard', 'api mastercard', sysdate, 1);

insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (3, 'CRISTIAN HUANCO', '12345678921', 'Visa', 'api visa', sysdate, 2);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (4, 'CRISTIAN HUANCO', '12345678922', 'Mastercard', 'api mastercard', sysdate, 2);

insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (5, 'JULIETA VILLAGRA', '12345678931', 'Visa', 'api visa', sysdate, 3);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (6, 'JULIETA VILLAGRA', '12345678932', 'Mastercard', 'api mastercard', sysdate, 3);

insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (7, 'DANIELA TRIADOR', '12345678941', 'Visa', 'api visa', sysdate, 4);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (8, 'DANIELA TRIADOR', '12345678942', 'Mastercard', 'api mastercard', sysdate, 4);

commit;
SELECT COUNT(*) as from billetera_abel.companies;


--Insertar datos en la tabla contacts
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (1, 'contacto cristian', 'cristian@gmail.com', 1);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (2, 'contacto juli', 'julieta@gmail.com', 1);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (3, 'contacto abel', 'abel@gmail.com', 2);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (4, 'contacto juli', 'julieta@gmail.com', 2);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (5, 'contacto daniela', 'daniela@gmail.com', 3);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (6, 'contacto juli', 'julieta@gmail.com', 4);
commit;
SELECT COUNT(*) as from billetera_abel.contacts;


--Insertar datos en la tabla de type of transactions
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (1, 1000, '+', sysdate,'RAPIPAGO','12311', 1, 1, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (2, 80, '+', sysdate,'VISA','12312', 2, 1, 1);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (3, 100, '-', sysdate,'CANTINA UNDEC','12313', 3, 1, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (4, 100, '-', sysdate,'cristian@gmail.com','12314', 4, 1, null);

insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (5, 2000, '+', sysdate,'PAGO FACIL','123211', 1, 2, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (6, 100, '-', sysdate,'MODATECH','12313', 3, 2, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (7, 100, '+', sysdate,'abel@gmail.com','12314', 4, 2, null);

commit;
SELECT COUNT(*) as from billetera_abel.transactions;


-- Creacion de secuencias que empiezn en 10 para no afectar los registros previamente cargados 
-- Secuencia para type_of_transactions
CREATE SEQUENCE seq_type_of_transactions START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;
-- Secuencia para users
CREATE SEQUENCE seq_users START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;
-- Secuencia para wallets
CREATE SEQUENCE seq_wallets START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;
-- Secuencia para companies
CREATE SEQUENCE seq_companies START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;
-- Secuencia para contacts
CREATE SEQUENCE seq_contacts START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;
-- Secuencia para transactions
CREATE SEQUENCE seq_transactions START WITH 10 INCREMENT BY 1 NOCACHE NOCYCLE;


-- MOfiicar las tablas para asigna el valor de las secuanci por defecto en los primary key
-- Modificar la tabla type_of_transactions para usar la secuencia
ALTER TABLE billetera_abel.type_of_transactions MODIFY (tpe_id DEFAULT seq_type_of_transactions.NEXTVAL);
-- Modificar la tabla users para usar la secuencia
ALTER TABLE billetera_abel.users MODIFY (usr_id DEFAULT seq_users.NEXTVAL);
-- Modificar la tabla wallets para usar la secuencia
ALTER TABLE billetera_abel.wallets MODIFY (wal_id DEFAULT seq_wallets.NEXTVAL);
-- Modificar la tabla companies para usar la secuencia
ALTER TABLE billetera_abel.companies MODIFY (cpn_id DEFAULT seq_companies.NEXTVAL);
-- Modificar la tabla contacts para usar la secuencia
ALTER TABLE billetera_abel.contacts MODIFY (con_id DEFAULT seq_contacts.NEXTVAL);
-- Modificar la tabla transactions para usar la secuencia
ALTER TABLE billetera_abel.transactions MODIFY (tra_id DEFAULT seq_transactions.NEXTVAL);


-- Ccrear nuevo usuario para lectura y asisgna privilegios
CREATE USER billetera_dev IDENTIFIED BY Micontrasenia2023 DEFAULT TABLESPACE data;
GRANT CREATE SESSION TO billetera_dev;
GRANT SELECT ON billetera_abel.type_of_transactions TO billetera_dev;
GRANT SELECT ON billetera_abel.users TO billetera_dev;
GRANT SELECT ON billetera_abel.wallets TO billetera_dev;
GRANT SELECT ON billetera_abel.companies TO billetera_dev;
GRANT SELECT ON billetera_abel.contacts TO billetera_dev;
GRANT SELECT ON billetera_abel.transactions TO billetera_dev;
