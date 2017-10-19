from flask import Flask, json, jsonify, request, render_template
from middleware_db import ConnectDB
import ast  # used to convert json object from <unicode> to <dict> type

app = Flask(__name__)
connObj = ConnectDB()   # Obtain a DB connection enabled object.
                        # This obj will come from middleware_db.py file

# Endpoint for SHIELD Homepage
@app.route('/')
def homepage():
    return "Welcome to SHIELD!"

# Endpoint for login check
@app.route('/api_login', methods=['POST'])
def login_check():
    login_form_data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    username = login_form_data['inputUsername']
    password = login_form_data['inputPassword']
    # print username, password
    login_json = {
        "username":username,
        "password":password
    }
    resultSet = connObj.NewSelect('customer', login_json)
    if resultSet == 'error':
        error = {
            "message":"Error"
        }
        return jsonify(error)
    success = {
        "message": {
            "u_id":resultSet[0][0]
        }
    }
    # print resultSet
    return  jsonify(success)


# Endpoint for getting logged in user's profile
@app.route('/get_profile', methods=['POST'])
def getProfile():
    userID = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewSelect('customer', userID)
    if resultSet == 'error':
        error = {
            "message":"Error"
        }
        return jsonify(error)
    success = {
        "message": {
            "u_id": resultSet[0][0],
            "username":resultSet[0][1],
            "email":resultSet[0][5],
            "first_name":resultSet[0][6],
            "last_name": resultSet[0][7],
            "address": resultSet[0][8],
            "street": resultSet[0][9],
            "state": resultSet[0][10],
            "zip": resultSet[0][11],
            "country": resultSet[0][12],
            "contact_number": resultSet[0][13]
        }
    }
    print resultSet
    return jsonify(success)

# Endpoint for creating/updating user profile
@app.route('/create_update_profile', methods=['POST'])
def createORupdate():
    # For posting form data to DB
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewUpdate('customer', data)
    # print resultSet
    if resultSet == 'error':
        error = {
            "message": "Error"
        }
        return jsonify(error)

    success = {
        "message": "Your profile has been updated successfully!"
    }
    return jsonify(success)

# Endpoint to fetch keylog data
@app.route('/getKeylogData/<user_id>', methods = ['GET'])
def getKeyLogs(user_id):
    data = {"u_id":user_id}
    resultSet = connObj.NewSelect('keylog', data)
    if resultSet == 'error':
        error = {
            "message": "Error."
        }
        return jsonify(error)

    resultSetArray = []
    for record in resultSet:
        recordJson = {
            "u_id": record[0],
            "keylog_timestamp": record[1],
            "application_name": record[2],
            "log_text": record[3],
            "notification_id": record[4],
            "keylog_id": record[5],
            "unique_identifier": record[6],
            "img": record[7]
        }
        resultSetArray.append(recordJson)
    success = {
        "message":resultSetArray
    }
    # print resultSet
    return jsonify(success)

# Endpoint to change password
@app.route('/change_pass', methods = ['POST'])
def changePass():
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    # print data
# Check if the old password given is valid
    dataToCheck = {
        "u_id": data["u_id"],
        "password": data["old_pass"]
    }

    entry = connObj.NewSelect('customer', dataToCheck)
    if len(entry) == 0:
        invalid = {
        "message": "Invalid Old Password."
        }
        return jsonify(invalid)

# Continue to update new password
    dataToUpdate = {
        "u_id": data["u_id"],
        "password": data["new_pass"]
    }

    resultSet = connObj.NewUpdate('customer', dataToUpdate)

    if resultSet == 'error':
        error = {
            "message": "Error."
        }
        return jsonify(error)
    success = {
        "message": "Your password has been updated successfully!"
    }
    return jsonify(success)


# Testing code block
# Testing SELECT function
@app.route('/test_select', methods=['POST'])
def testSelect():
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewSelect('phones', data)
    print type(resultSet)
    # resultSet = connObj.NewSelect('phones')
    if resultSet == 'error':
        error = {
            "message": "Unexpected Error Occurred."
        }
        return jsonify(error)
    success = {
        "message": "Retrieved successfully!",
        "response_data":resultSet
    }
    return jsonify(success)

# Testing INSERT function
@app.route('/test_insert', methods=['POST'])
def testInsert():
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewInsert('phones', data)
    if resultSet == 'error':
        error = {
            "message": "Unexpected Error Occurred."
        }
        return jsonify(error)
    success = {
        "message": "Record inserted successfully!"
    }
    return jsonify(success)

# -- Testing bloack ends --

if __name__ == "__main__":
    app.run(debug=True)

