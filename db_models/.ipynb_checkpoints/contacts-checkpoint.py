from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select, join
from config_vars import BBDD_CONNECTION

Base = declarative_base()

from . import users
from . import wallets
class Contacts(Base):
    __tablename__ = "contacts"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    con = Table("contacts", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_contacts(cls, *, con_id):
        """
        cual es el contacto con id
        """
        query = select([cls.con]).where(cls.con.c.con_id == con_id)
        return query
        
    @classmethod
    def all_contacts(cls):
        """
        Cuáles son todas los contactos
        """
        query = select([cls.con])
        return query

    @classmethod
    def contacts_by_user(cls, * , usr_id):
        """ Cuáles son todos los contacts del user usr_id """
        j = join(cls.con, wallets.Wallets.wal, cls.con.c.wal_id == wallets.Wallets.wal.c.wal_id).join( users.Users.usr, wallets.Wallets.wal.c.usr_id == users.Users.usr.c.usr_id)
        query = (select([cls.con]).select_from(j).where(users.Users.usr.c.usr_id == usr_id))
        return query