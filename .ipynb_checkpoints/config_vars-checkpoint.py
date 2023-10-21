#BBDD_CONNECTION = "postgresql://cristian:Ru7|97=(73Fb@hcaprod.kunan.com.ar/rasa"  
#BBDD_CONNECTION = "postgresql://abel:uR969hy;MkRQ@hcaprod.kunan.com.ar/rasa"  
BBDD_CONNECTION = "oracle+cx_oracle://billetera_abel:Micontrasenia2023@basededatosii_medium/?encoding=UTF-8&nencoding=UTF-8"
#BBDD_CONNECTION = "oracle+cx_oracle://billetera_dev:Micontrasenia2023@basededatosii_medium/?encoding=UTF-8&nencoding=UTF-8"
import cx_Oracle

d="/opt/oracle/instantclient_19_20"
print(d)
cx_Oracle.init_oracle_client(lib_dir=d)

