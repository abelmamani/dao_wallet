from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select, join
from config_vars import BBDD_CONNECTION

Base = declarative_base()


class TypeOfTransactions(Base):
    __tablename__ = "type_of_transactions"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    tpe = Table("type_of_transactions", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_typeoftransactions(cls, *, tpe_id):
        """
        Cuá es el tipo de transaction con id tpe_id
        """
        query = select([cls.tpe]).where(cls.tpe.c.tpe_id == tpe_id)
        return query
        
    @classmethod
    def all_typeoftransactions(cls):
        """
        Cuáles son todos los tipos de transacciones
        """
        query = select([cls.tpe])
        return query