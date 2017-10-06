from flask import Flask, json, jsonify, request
from middleware_db import ConnectDB
import ast

app = Flask(__name__)
connObj = ConnectDB()   # Obtain a DB connection enabled object


@app.route('/')
def homepage():
    return "Welcome to SHIELD!"

@app.route('/get_profile', methods=['POST'])
def getProfile():
    userID = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewSelect('customer', userID)
    if not resultSet:
        empty = {
            "":""
        }
    success = {
        "message":str(resultSet)
    }
    return jsonify(success)

@app.route('/create_update_profile', methods=['POST'])
def createORupdate():
    # For posting form data to DB
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewUpdate('customer', data)
    # print resultSet
    if resultSet:
        error = {
            "message": "Error"
        }
        return jsonify(error)
    success = {
        "message": "Your profile has been updated successfully!"
    }
    return jsonify(success)


if __name__ == "__main__":
    app.run(debug=True)

