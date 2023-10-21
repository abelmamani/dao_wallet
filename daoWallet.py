#from sqlalchemy import create_engine, select, join, MetaData, Table
import sys
import os
dirname = os.path.dirname(__file__)
 
sys.path.append(dirname)
sys.path.append(dirname+"/db_models/")
from sqlalchemy import create_engine, select, join, MetaData, Table

#from db_models.headquarte import Headquarters
from db_models.typeoftransactions import TypeOfTransactions
from db_models.users import Users
from db_models.companies import Companies
from db_models.contacts import Contacts
from db_models.transactions import Transactions
from config_vars import BBDD_CONNECTION


class WalletDAO:
    print("starting")
    engine = create_engine(BBDD_CONNECTION)
    connection = engine.connect()
    print("finished connection")
    metadata = MetaData()
    
    def get_typeoftransactions(self, *, tpe_id=None):
        if tpe_id:
            query = TypeOfTransactions.single_typeoftransactions(tpe_id=tpe_id)
        else:
            query = TypeOfTransactions.all_typeoftransactions()
        return self.connection.execute(query).fetchall()
        
    def get_users(self, *, usr_id=None, usr_name=None):
        if usr_id:
            query = Users.single_users(usr_id=usr_id)
        elif usr_name:
            query = Users.users_by_name_or_last_name(usr_name=usr_name)
        else:
            query = Users.all_users()
        return self.connection.execute(query).fetchall()
        
    def insert_user(self, usr_name, usr_last_name, usr_email, usr_password):
        query = Users.insert_user(usr_name, usr_last_name, usr_email, usr_password)
        return self.connection.execute(query)
        
    def update_user(self,usr_id, usr_name, usr_last_name, usr_email, usr_password):
        query = Users.update_user(usr_id, usr_name, usr_last_name, usr_email, usr_password)
        return self.connection.execute(query)

    def delete_user(self, usr_id):
        query = Users.delete_user(usr_id)
        return self.connection.execute(query)
            
    def get_companies(self, *, cpn_id=None, usr_id=None):
        if cpn_id:
            query = Companies.single_companies(cpn_id = cpn_id)
        elif usr_id:
            query = Companies.companies_by_user(usr_id = usr_id)
        else:
            query = Companies.all_companies()
        return self.connection.execute(query).fetchall()
        
    def get_contacts(self, *, con_id=None, usr_id=None):
        if con_id:
            query = Contacts.single_contacts(con_id = con_id)
        elif usr_id:
            query = Contacts.contacts_by_user(usr_id = usr_id)
        else:
            query = Contacts.all_contacts()
        return self.connection.execute(query).fetchall()
        
    def get_transactions(self, *, tra_id=None, usr_id=None, tpe_id=None):
        if tra_id:
            query = Transactions.single_transactions(tra_id = tra_id)
        elif usr_id and tpe_id:
            query = Transactions.transactions_by_user_and_type_of_transactions(usr_id = usr_id, tpe_id = tpe_id)
        elif usr_id:
            query = Transactions.transactions_by_user(usr_id = usr_id)
        elif tpe_id:
            query = Transactions.transactions_by_type_of_transactions(tpe_id = tpe_id)
        else:
            query = Transactions.all_transactions()
        return self.connection.execute(query).fetchall()
