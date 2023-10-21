# Descripcion del problema a resolver
* Como usuario de la billetera virtual me gustaría poder ordenar y consolidar todas mis transacciones en un solo lugar donde pueda ver los gastos que realizo con mis tarjetas de crédito, débito y efectivo como así también los ingresos, egresos, transferencias, extracciones de dinero y cobros que tengo.
* Otra de las transacciones posibles a tener en cuenta son los ingresos/egresos en efectivo para recargar saldo.
* Para el ingreso/egreso de dinero en la cuenta, se efectuará mediante un Rapipago o PagoFacil.y ante situaciones particulares poder retirar efectivo de un cajero automatico

# Dao
* consultar todos los tipos de transaccoines
* consultar un tipo de transacion por id
* consultar todos los usuarios
* consultar un usuario por id
* consultar todos los usuarios por nombre o apellido
* consultar todas la compañias
* consultar una compañia por id
* consultar todas las tarjetas de un usuario
* consultart todos los contactos
* consultar un contacto por id
* consultar todas los contactos de un usuario
* consultar todas las transacciones
* consultar una transaccion por id
* consultar todas las transacciones de un usuario
* consultar todas las transacciones de un tipo de transaccion en especifico
* consultar todas las transacciones de un usuario y de un tipo de transaciont en especifico
* registrar un nuevo usuario
* actualizar los datos de un usuario
* baja de un usuario
  
### Diseño de la BD
![Diagrama](DER.png)
#### Before you begin, you’ll need:
* IDE or Text editor 
* Python 3.6 or 3.7
* pip install --upgrade pip

#### Create database schema
* [dboraclescripts](dboraclescripts.sql)
* [dbpostgresqlscripts](dbpostgresqlscripts.sql)

#### Create the virtual environment
* python3 -m venv ./venv

#### Activate the virtual environment
* source ./venv/bin/activate

#### Install jupyter
* pip install notebook 

#### Install Libs
* pip install sqlalchemy==1.4

#### For Oracle Databases
* pip install cx_Oracle==8.3

#### For Oracle Databases Autonomous (instant client)
https://docs.oracle.com/en-us/iaas/autonomous-database-serverless/doc/connecting-python-tls.html
https://csiandal.medium.com/install-oracle-instant-client-on-ubuntu-4ffc8fdfda08

* pip install oracledb

#### For PostgreSQL
* [Install PostgreSQL Libs](https://springmerchant.com/bigcommerce/psycopg2-virtualenv-install-pg_config-executable-not-found/)
* sudo apt-get install libpq-dev python-dev
* sudo apt-get update
* pip install psycopg2


