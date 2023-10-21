from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select
from config_vars import BBDD_CONNECTION

Base = declarative_base()


class Wallets(Base):
    __tablename__ = "wallets"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    wal = Table("wallets", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_walletss(cls, *, wal_id):
        """
        cual es el wallet con id 
        """
        query = select([cls.wal]).where(cls.wal.c.wal_id == wal_id)
        return query
        
    @classmethod
    def all_wallets(cls):
        """
        Cuáles son todas las wallets
        """
        query = select([cls.wal])
        return query