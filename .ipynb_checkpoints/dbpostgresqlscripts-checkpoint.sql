--El presente script tiene los scripts de los objetos de la base de datos en postgresql

--Crear las tablas
CREATE TABLE billetera_abel.type_of_transactions (
    tpe_id   INTEGER NOT NULL,
    tpe_name VARCHAR(45) NOT NULL
);
ALTER TABLE billetera_abel.type_of_transactions ADD CONSTRAINT type_of_transactions_pk PRIMARY KEY ( tpe_id );

CREATE TABLE billetera_abel.users (
    usr_id        INTEGER NOT NULL,
    usr_name      VARCHAR(45) NOT NULL,
    usr_last_name VARCHAR(45) NOT NULL,
    usr_email     VARCHAR(45) NOT NULL,
    usr_password  VARCHAR(45) NOT NULL
);
ALTER TABLE billetera_abel.users ADD CONSTRAINT users_pk PRIMARY KEY ( usr_id );


CREATE table billetera_abel.wallets (
    wal_id INTEGER NOT NULL,
    usr_id INTEGER NOT NULL
);
ALTER TABLE billetera_abel.wallets ADD CONSTRAINT wallets_pk PRIMARY KEY ( wal_id );

CREATE TABLE billetera_abel.companies (
    cpn_id              INTEGER NOT NULL,
    cpn_holder_name     VARCHAR(45) NOT NULL,
    cpn_number          VARCHAR(20),
    cpn_company_name    VARCHAR(45) NOT NULL,
    cpn_api_key         VARCHAR(45) NOT NULL,
    cpn_expiration_date DATE NOT NULL,
    wal_id              INTEGER NOT NULL
);
ALTER TABLE billetera_abel.companies ADD CONSTRAINT companies_pk PRIMARY KEY ( cpn_id );

CREATE TABLE billetera_abel.contacts (
    con_id    INTEGER NOT NULL,
    con_name  VARCHAR(45) NOT NULL,
    con_email VARCHAR(45) NOT NULL,
    wal_id    INTEGER NOT NULL
);
ALTER TABLE billetera_abel.contacts ADD CONSTRAINT contacts_pk PRIMARY KEY ( con_id );

CREATE table billetera_abel.transactions (
    tra_id          INTEGER NOT NULL,
    tra_amount      FLOAT(11) NOT NULL,
    tra_signe       VARCHAR(45) NOT NULL,
    tra_date        DATE NOT NULL,
    tra_description VARCHAR(45) NOT NULL,
    tra_tracking    VARCHAR(45) NOT NULL,
    tpe_id          INTEGER NOT NULL,
    wal_id          INTEGER NOT NULL,
    cpn_id          iNTEGER
);
ALTER TABLE billetera_abel.transactions ADD CONSTRAINT transactions_pk PRIMARY KEY ( tra_id );

-- alterar las tablas para añadir las constraints de tipo FK
-- agregar constraint FK para la tabla wallets
ALTER TABLE billetera_abel.wallets
    ADD CONSTRAINT wallets_users_fk FOREIGN KEY ( usr_id )
        REFERENCES billetera_abel.users ( usr_id );

-- agregar constraint FK para la tabla companies
ALTER TABLE billetera_abel.companies
    ADD CONSTRAINT companies_wallets_fk FOREIGN KEY ( wal_id )
        REFERENCES billetera_abel.wallets ( wal_id );

-- agregar constraint FK para la tabla contacts
ALTER TABLE billetera_abel.contacts
    ADD CONSTRAINT contacts_wallets_fk FOREIGN KEY ( wal_id )
        REFERENCES billetera_abel.wallets ( wal_id );

-- agregar constraint FK para la tabla transactions
ALTER TABLE billetera_abel.transactions
    ADD CONSTRAINT transactions_companies_fk FOREIGN KEY ( cpn_id )
        REFERENCES billetera_abel.companies ( cpn_id );
ALTER TABLE billetera_abel.transactions
    ADD CONSTRAINT transactions_type_of_transactions_fk FOREIGN KEY ( tpe_id )
        REFERENCES billetera_abel.type_of_transactions ( tpe_id );
ALTER table billetera_abel.transactions
    ADD CONSTRAINT transactions_wallets_fk FOREIGN KEY ( wal_id )
        REFERENCES billetera_abel.wallets ( wal_id );


--Insertar los datos
--Insertar datos en la tabla de type of transactions
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(1, 'CASH');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(2, 'CARD');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(3, 'INVOICE');
insert into billetera_abel.type_of_transactions (tpe_id, tpe_name) VALUES(4, 'TRANSFER');
commit;
SELECT *  from billetera_abel.type_of_transactions;

--Insertar datos en la tabla de users
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(1, 'Abel','Mamani', 'abel@gmail.com', '1234567891');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(2, 'Cristina','Mamani', 'cristian@gmail.com', '1234567892');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(3, 'Julieta','Villagra', 'julieta@gmail.com', '1234567893');
insert into billetera_abel.users (usr_id, usr_name, usr_last_name, usr_email, usr_password) VALUES(4, 'Daniela','Triador', 'daniela@gmail.com', '1234567894');
commit;
select * from billetera_abel.users;

--Insertar datos en la tabla wallets
insert into billetera_abel.wallets (wal_id, usr_id) values (1, 1);
insert into billetera_abel.wallets (wal_id, usr_id) values (2, 2);
insert into billetera_abel.wallets (wal_id, usr_id) values (3, 3);
insert into billetera_abel.wallets (wal_id, usr_id) values (4, 4);
commit;
SELECT * from billetera_abel.wallets;

--Insertar datos en la tabla companies
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (1, 'ABEL MAMANI', '12345678911', 'Visa', 'api visa', now(), 1);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (2, 'ABEL MAMANI', '12345678912', 'Mastercard', 'api mastercard', now(), 1);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (3, 'CRISTIAN HUANCO', '12345678921', 'Visa', 'api visa', now(), 2);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (4, 'CRISTIAN HUANCO', '12345678922', 'Mastercard', 'api mastercard', now(), 2);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (5, 'JULIETA VILLAGRA', '12345678931', 'Visa', 'api visa', now(), 3);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (6, 'JULIETA VILLAGRA', '12345678932', 'Mastercard', 'api mastercard', now(), 3);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (7, 'DANIELA TRIADOR', '12345678941', 'Visa', 'api visa', now(), 4);
insert into billetera_abel.companies (cpn_id, cpn_holder_name, cpn_number, cpn_company_name, cpn_api_key, cpn_expiration_date, wal_id) 
values (8, 'DANIELA TRIADOR', '12345678942', 'Mastercard', 'api mastercard', now(), 4);
commit;
SELECT * from billetera_abel.companies;

--Insertar datos en la tabla contacts
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (1, 'contacto cristian', 'cristian@gmail.com', 1);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (2, 'contacto juli', 'julieta@gmail.com', 1);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (3, 'contacto abel', 'abel@gmail.com', 2);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (4, 'contacto juli', 'julieta@gmail.com', 2);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (5, 'contacto daniela', 'daniela@gmail.com', 3);
insert into billetera_abel.contacts (con_id, con_name, con_email, wal_id) values (6, 'contacto juli', 'julieta@gmail.com', 4);
commit;
SELECT * from billetera_abel.contacts;

--Insertar datos en la tabla de type of transactions
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (1, 1000, '+', now(),'RAPIPAGO','12311', 1, 1, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (2, 80, '+', now(),'VISA','12312', 2, 1, 1);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (3, 100, '-', now(),'CANTINA UNDEC','12313', 3, 1, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (4, 100, '-', now(),'cristian@gmail.com','12314', 4, 1, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (5, 2000, '+', now(),'PAGO FACIL','123211', 1, 2, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (6, 100, '-', now(),'MODATECH','12313', 3, 2, null);
insert into billetera_abel.transactions (tra_id, tra_amount, tra_signe, tra_date, tra_description, tra_tracking, tpe_id, wal_id, cpn_id)
values (7, 100, '+', now(),'abel@gmail.com','12314', 4, 2, null);
commit;
SELECT * from billetera_abel.transactions;

-- Creación de secuencias que empiezan en 10
CREATE SEQUENCE billetera_abel.seq_type_of_transactions START 10;
CREATE SEQUENCE billetera_abel.seq_users START 10;
CREATE SEQUENCE billetera_abel.seq_wallets START 10;
CREATE SEQUENCE billetera_abel.seq_companies START 10;
CREATE SEQUENCE billetera_abel.seq_contacts START 10;
CREATE SEQUENCE billetera_abel.seq_transactions START 10;

-- Modificar las tablas para asignar los valores de las secuencias por defecto en las primary keys
-- Modificar la tabla type_of_transactions para usar la secuencia
ALTER TABLE billetera_abel.type_of_transactions ALTER COLUMN tpe_id SET DEFAULT nextval('seq_type_of_transactions');
-- Modificar la tabla users para usar la secuencia
ALTER TABLE billetera_abel.users ALTER COLUMN usr_id SET DEFAULT nextval('seq_users');
-- Modificar la tabla wallets para usar la secuencia
ALTER TABLE billetera_abel.wallets ALTER COLUMN wal_id SET DEFAULT nextval('seq_wallets');
-- Modificar la tabla companies para usar la secuencia
ALTER TABLE billetera_abel.companies ALTER COLUMN cpn_id SET DEFAULT nextval('seq_companies');
-- Modificar la tabla contacts para usar la secuencia
ALTER TABLE billetera_abel.contacts ALTER COLUMN con_id SET DEFAULT nextval('seq_contacts');
-- Modificar la tabla transactions para usar la secuencia
ALTER TABLE billetera_abel.transactions ALTER COLUMN tra_id SET DEFAULT nextval('seq_transactions');

-- Utilizar otro usuario para lectura y asignar privilegios para el esquema billetera_abel
-- grant select on all tables in schema billetera_abel TO cristian;
-- revoke select on all tables in schema billetera_abel from cristian;
grant usage on schema billetera_abel to cristian;
grant select on billetera_abel.typeoftransactions to cristian
grant select on billetera_abel.users to cristian
grant select on billetera_abel.wallets to cristian
grant select on billetera_abel.companies to cristian
grant select on billetera_abel.contacts to cristian
grant select on billetera_abel.transactions to cristian