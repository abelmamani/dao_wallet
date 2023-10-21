from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select, join
from config_vars import BBDD_CONNECTION

Base = declarative_base()
from . import users
from . import wallets

class Companies(Base):
    __tablename__ = "companies"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    cpn = Table("companies", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_companies(cls, *, cpn_id):
        """ cual es la compañia con id """
        query = select([cls.cpn]).where(cls.cpn.c.cpn_id == cpn_id)
        return query
        
    @classmethod
    def all_companies(cls):
        """ Cuáles son todas las compañias """
        query = select([cls.cpn])
        return query
        
    @classmethod
    def companies_by_user(cls, * , usr_id):
        """ Cuáles son todas las companies del user usr_id """
        j = join(cls.cpn, wallets.Wallets.wal, cls.cpn.c.wal_id == wallets.Wallets.wal.c.wal_id).join(users.Users.usr,
                wallets.Wallets.wal.c.usr_id
                == users.Users.usr.c.usr_id)
        query = (select([cls.cpn]).select_from(j).where(users.Users.usr.c.usr_id == usr_id))
        return query