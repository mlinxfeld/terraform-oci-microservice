import io
import os
import json
import cx_Oracle
from fdk import response


def handler(ctx, data: io.BytesIO=None):
    resp = dbaccess(data)

    return response.Response(
        ctx, response_data=json.dumps(
            {"message": resp}),
        headers={"Content-Type": "application/json"}
    )

def dbaccess(data):
    
    try: 
        atp_admin_user = "admin"
        atp_admin_password = os.getenv('OCIFN_ADMIN_ATP_PASSWORD')
        atp_user = os.getenv('OCIFN_ATP_USER')
        atp_password = os.getenv('OCIFN_ATP_PASSWORD')
        atp_alias = os.getenv('OCIFN_ATP_ALIAS')

        ## Connecting as ATP ADMIN User, creation of user for customer table

        connection = cx_Oracle.connect(atp_admin_user, atp_admin_password, atp_alias)
        cursor = connection.cursor()

        rs = cursor.execute("create user {} identified by {}".format(atp_user,atp_password))
        rs = cursor.execute("grant create session to {}".format(atp_user))
        rs = cursor.execute("grant create table to {}".format(atp_user))
        rs = cursor.execute("grant unlimited tablespace to {}".format(atp_user))

        cursor.close()
        connection.close()

        ## Connecting as ATP User, creation of customers table with two customer records.

        connection2 = cx_Oracle.connect(atp_user, atp_password, atp_alias)
        cursor2 = connection2.cursor()
        
        rs = cursor2.execute('''create table customers (custid number, custname varchar2(100))''')
        rs = cursor2.execute('''insert into customers values (1,'First Customer')''')
        rs = cursor2.execute('''insert into customers values (2,'Second Customer')''')
        rs = cursor2.execute('COMMIT')

        cursor2.close()
        connection2.close()

    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "Success! User with privileges created, table customers populated.", }
 