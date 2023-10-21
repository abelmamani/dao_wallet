from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select, join
from config_vars import BBDD_CONNECTION

Base = declarative_base()

from . import users
from . import wallets
from . import typeoftransactions
class Transactions(Base):
    __tablename__ = "transactions"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    tra = Table("transactions", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_transactions(cls, *, tra_id):
        """ cual es la transaction con id """
        query = select([cls.tra]).where(cls.tra.c.tra_id == tra_id)
        return query
        
    @classmethod
    def all_transactions(cls):
        """ Cuáles son todas las transacciones """
        query = select([cls.tra])
        return query

    @classmethod
    def transactions_by_user(cls, * , usr_id):
        """ Cuáles son todas las transacciones del user usr_id """
        j = join(cls.tra, wallets.Wallets.wal,
                cls.tra.c.wal_id == wallets.Wallets.wal.c.wal_id,
            ).join(
                users.Users.usr,
                wallets.Wallets.wal.c.usr_id
                == users.Users.usr.c.usr_id,
            )
        query = (select([cls.tra]).select_from(j).where(users.Users.usr.c.usr_id == usr_id))
        return query

    @classmethod
    def transactions_by_type_of_transactions(cls, * , tpe_id):
        """ Cuáles son todas las transacciones del tipo tipo de transaction tpe_id """ 
        j = join(cls.tra, typeoftransactions.TypeOfTransactions.tpe, cls.tra.c.tpe_id == typeoftransactions.TypeOfTransactions.tpe.c.tpe_id)
        query = (select([cls.tra]).select_from(j).where(typeoftransactions.TypeOfTransactions.tpe.c.tpe_id == tpe_id))
        return query

    @classmethod
    def transactions_by_user_and_type_of_transactions(cls, * , usr_id, tpe_id):
        """ Cuáles son todas las transacciones del user usr_id y el tipo de transaction tpe """
        j = join(cls.tra, wallets.Wallets.wal, cls.tra.c.wal_id == wallets.Wallets.wal.c.wal_id,
                ).join(
                    users.Users.usr,
                    wallets.Wallets.wal.c.usr_id == users.Users.usr.c.usr_id, 
                ).join(
                     typeoftransactions.TypeOfTransactions.tpe,
                    cls.tra.c.tpe_id == typeoftransactions.TypeOfTransactions.tpe.c.tpe_id)
        query = (select([cls.tra]).select_from(j).where(users.Users.usr.c.usr_id == usr_id))
        return query