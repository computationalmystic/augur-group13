from flask import Flask
import subprocess

app = Flask(__name__)

@app.route("/")
def hello():
	p = subprocess.Popen(["dosocs2", "oneshot", "/home/luke/University/SP 2019/Software Engineering/dosocstestrepo/WorkshopExample/"], stdout=subprocess.PIPE)
	
	return p.communicate()
