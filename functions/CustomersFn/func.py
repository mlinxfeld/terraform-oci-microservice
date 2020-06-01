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

    resp = dbaccess(cust_id)

    return response.Response(
        ctx, response_data=json.dumps(
            {"message": resp}),
        headers={"Content-Type": "application/json"}
    )

def dbaccess(cust_id):
    
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