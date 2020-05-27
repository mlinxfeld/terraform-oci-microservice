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
    	connection = cx_Oracle.connect('admin', 'BEstrO0ng_#11', 'fkatpdb5_medium')
    	cursor = connection.cursor()
    	rs = cursor.execute("select name from v$database")
    	dbname = rs.fetchone()
    	cursor.close()
    	connection.close()
    except Exception as e:
        return {"Result": "Not connected to ATP! Exception{}".format(str(e)),}

    return {"Result": "I am connected to ATP Database via private endpoint! ATP dbname taken from v$database view is {}".format(dbname[0]),}