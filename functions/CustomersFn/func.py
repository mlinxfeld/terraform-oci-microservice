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
    	atp_user = os.getenv('OCIFN_ATP_USER')
    	atp_password = os.getenv('OCIFN_ATP_PASSWORD')
    	atp_alias = os.getenv('OCIFN_ATP_ALIAS')

    	connection = cx_Oracle.connect(atp_user, atp_password, atp_alias)
    	cursor = connection.cursor()
    	rs = cursor.execute("select * from customers")
    	rows = rs.fetchall()
    	json_output = json.dumps(rows)
    	cursor.close()
    	connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception: {}".format(str(e)),}

    return {"Result": "{}".format(json_output),}