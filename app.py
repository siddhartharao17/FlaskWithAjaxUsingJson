from flask import Flask, render_template, request, json, jsonify

app = Flask(__name__)

# func() to handle a request sent on end point /
@app.route('/')
def homepage():
    return "Welcome to Python Flask"

# func() to handle a request sent on end point /signUp
@app.route('/signUp')
def signUp():
    return render_template('signUp.html')

# func() to handle a request sent on end point /signUpUser
@app.route('/signUpUser', methods=['POST'])
def signUpUser():
    # print request.form
    user = request.form['username']
    password = request.form['password']
    jsonStr = json.dumps({
        'status':'OK',
        'user':user,
        'password':password
    })
    return jsonify(jsonStr)

if __name__ == "__main__":
    app.run()
