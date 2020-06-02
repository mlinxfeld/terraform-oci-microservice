import io
import os
import json
import cx_Oracle
from fdk import response


def handler(ctx, data: io.BytesIO=None):
    cust_id = "All"
    try:
        body = json.loads(data.getvalue())
        cust_id = str(body.get("cust_id"))
    except (Exception, ValueError) as ex:
        print(str(ex))

    if ctx.Method() == "GET":
        resp = select_customer(cust_id)
    
    if ctx.Method() == "DELETE":
        resp = delete_customer(cust_id)
    
    if ctx.Method() == "PUT":
        try:
            body = json.loads(data.getvalue())
            cust_name = str(body.get("cust_name"))
        except (Exception, ValueError) as ex:
            print(str(ex))
        resp = update_customer(cust_id, cust_name)
    
    if ctx.Method() == "POST":
        try:
            body = json.loads(data.getvalue())
            cust_name = str(body.get("cust_name"))
        except (Exception, ValueError) as ex:
            print(str(ex))
        resp = insert_customer(cust_id, cust_name)

    return response.Response(
        ctx, response_data=json.dumps(
            {"message": resp}),
        headers={"Content-Type": "application/json"}
    )

def select_customer(cust_id):
    
    try: 
        atp_user = os.getenv('OCIFN_ATP_USER')
        atp_password = os.getenv('OCIFN_ATP_PASSWORD')
        atp_alias = os.getenv('OCIFN_ATP_ALIAS')

        connection = cx_Oracle.connect(atp_user, atp_password, atp_alias)
        cursor = connection.cursor()
        if cust_id == "All":
            rs = cursor.execute("select * from customers")
            rows = rs.fetchall()
        else:
            rs = cursor.execute("select * from customers where cust_id={}".format(cust_id))
            rows = rs.fetchone()
        json_output = json.dumps(rows)
        cursor.close()
        connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "{}".format(json_output),}

def delete_customer(cust_id):
    
    try: 
        atp_user = os.getenv('OCIFN_ATP_USER')
        atp_password = os.getenv('OCIFN_ATP_PASSWORD')
        atp_alias = os.getenv('OCIFN_ATP_ALIAS')

        connection = cx_Oracle.connect(atp_user, atp_password, atp_alias)
        cursor = connection.cursor()
        if cust_id != "All":
            rs = cursor.execute("delete from customers where cust_id={}".format(cust_id))
            rs = cursor.execute('COMMIT')
        cursor.close()
        connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "Row deleted (cust_id={})".format(cust_id),}

def update_customer(cust_id, cust_name):
    
    try: 
        atp_user = os.getenv('OCIFN_ATP_USER')
        atp_password = os.getenv('OCIFN_ATP_PASSWORD')
        atp_alias = os.getenv('OCIFN_ATP_ALIAS')

        connection = cx_Oracle.connect(atp_user, atp_password, atp_alias)
        cursor = connection.cursor()
        if cust_id != "All":
            rs = cursor.execute("update customers set cust_name='{}' where cust_id={}".format(cust_name, cust_id))
            rs = cursor.execute('COMMIT')
        cursor.close()
        connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "Row updated (cust_id={}, cust_name={})".format(cust_id, cust_name),}

def insert_customer(cust_id, cust_name):
    
    try: 
        atp_user = os.getenv('OCIFN_ATP_USER')
        atp_password = os.getenv('OCIFN_ATP_PASSWORD')
        atp_alias = os.getenv('OCIFN_ATP_ALIAS')

        connection = cx_Oracle.connect(atp_user, atp_password, atp_alias)
        cursor = connection.cursor()
        if cust_id != "All":
            rs = cursor.execute("insert into customers values ({},'{}')".format(cust_id, cust_name))
            rs = cursor.execute('COMMIT')
        cursor.close()
        connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "Row inserted (cust_id={}, cust_name={})".format(cust_id, cust_name),}