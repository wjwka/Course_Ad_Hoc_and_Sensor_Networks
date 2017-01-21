from flask import Flask, request, redirect, url_for
from flask import render_template
app = Flask(__name__)

@app.route('/')
def init_webserver():
    return render_template('control.html')

@app.route('/ctrl', methods=['GET','POST'])
def ctrl_wheels():
    if(request.method == 'POST'):
        print "***********"
        print request.form
        print "***********"
        id = request.form['dir']
        if id == 'up':
            #forward command
            print 'FORWARD command received'
        elif id == 'down':
            #backward command
            print 'BACKWARD command received'
        elif id == 'left':
            #moveleft command
            print 'MOVELEFT command received'
        elif id == 'right':
            #moveright command
            print 'MOVERIGHT COMMAND RECEIVED'
    return redirect(url_for('init_webserver'))

@app.route('/data')
def render_data():
    return render_template("data.html")
