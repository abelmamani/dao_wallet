from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, create_engine, MetaData, Table, select, insert, or_
from config_vars import BBDD_CONNECTION

Base = declarative_base()


class Users(Base):
    __tablename__ = "users"
    print("entering parameters config")
    engine = create_engine(BBDD_CONNECTION)
    metadata = MetaData()
    usr = Table("users", metadata, autoload=True, autoload_with=engine, schema='billetera_abel')
    #id_not_in_db = Column(Integer, primary_key=True)
    id_not_in_db = Column(Integer, primary_key=True)
    print("finished config for parameters")
    
    @classmethod
    def single_users(cls, *, usr_id):
        # cual es el user con id 
        query = select([cls.usr]).where(cls.usr.c.usr_id == usr_id)
        return query
    
    @classmethod
    def users_by_name_or_last_name(cls,*,usr_name):
        query = select([cls.usr]).where(or_( cls.usr.c.usr_name.like(f'%{usr_name}%'), cls.usr.c.usr_last_name.like(f'%{usr_name}%')))
        return query
        
    @classmethod
    def all_users(cls):
        # cuáles son todos los tipos de transacciones
        query = select([cls.usr])
        return query
        
    @classmethod
    def insert_user(cls, usr_name, usr_last_name, usr_email, usr_password):
        # insertar un nuevo usuario
        insert_query = cls.usr.insert().values(
            usr_name=usr_name,
            usr_last_name=usr_last_name,
            usr_email=usr_email,
            usr_password=usr_password)
        return insert_query
        
    @classmethod
    def update_user(cls, usr_id, usr_name, usr_last_name,usr_email, usr_password):
        # actulizar usuario
        update_query = cls.usr.update().where(cls.usr.c.usr_id == usr_id).values(
            usr_name = usr_name,
            usr_last_name= usr_last_name,
            usr_email = usr_email,
            usr_password = usr_password)
        return update_query
    
    @classmethod
    def delete_user(cls, usr_id):
        # eliminar un usuario
        delete_query = cls.usr.delete().where(cls.usr.c.usr_id == usr_id)
        return delete_query