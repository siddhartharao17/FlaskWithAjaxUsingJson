from flask import Flask, json, jsonify, request, render_template
from middleware_db import ConnectDB
import os.path as path
import os
from base64 import b64encode
from json import dumps
from PIL import Image
from flask_mail import Mail, Message

from datetime import datetime
import ast  # used to convert json object from <unicode> to <dict> type
app = Flask(__name__)
connObj = ConnectDB()   # Obtain a DB connection enabled object.
                        # This obj will come from middleware_db.py file

app.config.update(
   #EMAIL SETTINGS
   MAIL_SERVER='smtp.gmail.com',
   MAIL_PORT=465,
   MAIL_USE_SSL=True,
   MAIL_USERNAME = 'shieldintrusionsystem@gmail.com',
   MAIL_PASSWORD = 'shieldteam1'
   )

mail = Mail(app)

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
        "message": { "u_id": resultSet[0][0]}}
    # print resultSet
    return jsonify(success)


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

# Endpoint for creating/updating payments
@app.route('/create_update_payments', methods=['POST'])
def updatePayments():

    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    # get uid and check if the table already contains u_id,
    # if yes, data will be updated, if no data will be inserted
    datatemp = {"u_id": data['u_id']}
    resultSet = connObj.NewSelect('credit_card', datatemp)

    if resultSet.__len__() == 0:
        resultSet = connObj.NewInsert('credit_card', data)
    else:
        resultSet = connObj.NewUpdate('credit_card', data)


    print resultSet
    # print resultSet
    if resultSet == 'error':
        error = {
            "message": "Error"
        }
        return jsonify(error)

    success = {
        "message": "Payment updated successfully !"
    }
    return jsonify(success)

# Endpoint for getting logged in user's payment info
@app.route('/get_payments', methods=['POST'])
def getPayments():
    userID = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    resultSet = connObj.NewSelect('credit_card', userID)
    if resultSet == 'error' or resultSet.__len__() == 0:
        error = {"message":"Error"}
        return jsonify(error)
    success = {
         "message": {
            "u_id": resultSet[0][0],
            "cc_number":resultSet[0][1],
             "cc_type": resultSet[0][2],
             "cc_name": resultSet[0][4],
            "cc_exdate": resultSet[0][5],
         }
    }
    print resultSet
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


# Endpoint for updating logs in database
@app.route('/api/post_keylogs/', methods=['POST'])
def update_key_logs():
    # For posting form data to DB

    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    data_temp = {"u_id": data['u_id']}
    resultSet = connObj.NewSelect('credit_card', data_temp)
    if resultSet.__len__() == 0:
        resultSet = connObj.NewInsert('keylog', data)
    else:
        resultSet = connObj.NewUpdate('keylog', data)

    # print resultSet
    if resultSet == 'error':
        error = {
            "message": "Error"
        }
        return jsonify(error)

    success = {
        "message": "Success"
    }
    person = {"email": "shielduser4@gmail.com", "name": "test_user4"}
    sendAlert(person)
    return jsonify(success)


# Endpoint for api request and inserting webcam capture in database
@app.route('/update_webcam_capture/', methods=['POST'])
def insert_webcam_capture():
    #  print data_temp
    # For fetching form request(images) sent by host
    file = request.files['media']

    # use uid_timestamp.png as a file name
    # if image folder is not there create one
    if not path.exists('Webcam_Images\\\\'):
        os.makedirs('Webcam_Images\\\\')
    file_name = (file.filename).split('.')[0]
    file_type =(file.filename).split('.')[1]
    imgurl = 'Webcam_Images\\\\' + file_name+'.'+file_type
    # print imgurl
    file.save(imgurl)
    # add images url to db
    now = datetime.now()
    # print now.strftime("%Y-%m-%d %H:%M:%S")
    data = {"u_id": 1,"image_url":imgurl,"webcam_date_time":now.strftime("%Y-%m-%d %H:%M:%S")}
    # print data
    resultSet = connObj.NewInsert('webcam_capture', data)
    if resultSet == 'error':
        error = {
            "message": "Error"
        }
        return jsonify(error)

    success = {
        "message": "Success"
    }
    person = {"email": "shielduser4@gmail.com", "name": "test_user4"}
    sendAlert(person)
    return jsonify(success)

# here
# Endpoint to fetch webcam data and display to user
@app.route('/getWebCamData/<user_id>', methods = ['GET'])
def getWebCam(user_id):
    data = {"u_id":user_id}
    resultSet = connObj.NewSelect('webcam_capture', data)
    if resultSet == 'error':
        error = {
            "message": "Error."
        }
        return jsonify(error)

    resultSetArray = []
    for record in resultSet:
        recordJson = {
            "u_id": record[0],
            "webcam_date_time": record[1],
            "image_url": record[5],
        }
        resultSetArray.append(recordJson)
    success = {
        "message":resultSetArray
    }
    # print resultSet
    return jsonify(success)

# # Endpoint to return image file for webcam url
@app.route('/getWebCamImages', methods = ['POST'])
def getWebCamImages():
    # import pdb; pdb.set_trace()
    data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
    path_file = data['image_url']
    print path_file
    with open(path_file, 'rb') as open_file:
        byte_content = open_file.read()

    # second: base64 encode read data
    # result: bytes (again)
    base64_bytes = b64encode(byte_content)
    # print base64_bytes
    # now: encoding the data to json
    print base64_bytes
    json_data = base64_bytes
    # print json_data
    # end
    resultSetArray = []
    resultSetArray.append(json_data)
    success = {
        "message":json_data
    }
    # print resultSet
    return jsonify(success)

# Function to send email.
def sendAlert(data):
    try:
        msg = Message("Intrusion Detected",
                      sender="shieldintrusionsystem@gmail.com",
                      recipients=[data['email']])
        msg.body = data['message']
        # msg.html = render_template('mails/alert.html')
        msg.html = '<!DOCTYPE html>' \
                   '<html>' \
                   '<head> ' \
                   '<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">' \
                   '</head>' \
                   '<body>' \
                   '<div class="container" style="border:1px solid; border-radius:20px; padding:30px">' \
                   '<h3>Hello ' + data['name'] + ',</h3> ' \
                                                 '<p>An intrusion was detected on your computer. ' \
                                                 'Please login into your account to view what was ' \
                                                 'captured during the attempt.</p>' \
                                                 '<p>Take Care,</p>' \
                                                 '<p>SHIELD</p>' \
                                                 '<img class="logo"src="https://images.vexels.com/media/users/3/142812/isolated/preview/992801ae3182fa95353e941cfcac9293-shield-logo-emblem-design-by-vexels.png"' \
                                                 'style="height:40px">' \
                                                 '</div>' \
                                                 '</body>' \
                                                 '</html>'
        mail.send(msg)
        return 'Mail sent!'
    except Exception, e:
        return str(e)   
# Testing code block
# Testing SELECT function
# @app.route('/test_select', methods=['POST'])
# def testSelect():
#     data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
#     resultSet = connObj.NewSelect('phones', data)
#     print type(resultSet)
#     # resultSet = connObj.NewSelect('phones')
#     if resultSet == 'error':
#         error = {
#             "message": "Unexpected Error Occurred."
#         }
#         return jsonify(error)
#     success = {
#         "message": "Retrieved successfully!",
#         "response_data":resultSet
#     }
#     return jsonify(success)

# Testing INSERT function
# @app.route('/test_insert', methods=['POST'])
# def testInsert():
#     data = ast.literal_eval(json.dumps(request.json, ensure_ascii=False))
#     resultSet = connObj.NewInsert('phones', data)
#     if resultSet == 'error':
#         error = {
#             "message": "Unexpected Error Occurred."
#         }
#         return jsonify(error)
#     success = {
#         "message": "Record inserted successfully!"
#     }
#     return jsonify(success)

# -- Testing bloack ends --

if __name__ == "__main__":
    app.run(debug=True)

