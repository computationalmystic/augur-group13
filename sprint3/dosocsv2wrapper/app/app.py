from flask import Flask, request, jsonify, abort
from git import Repo
import shutil, os, subprocess

app = Flask(__name__)

@app.route('/')
def index():
    return "Hello, World"

@app.route('/oneshot/', methods=['POST'])
def oneshot():
    # Check that it has a git url
    if not request.json or not 'url' in request.json:
        return abort(400)
    
    # TODO Validate url input instead of just assuming it is a .git url
    git_url = request.json["url"].rsplit('.', 1)[0] #Url without .git following
    url = git_url + "/archive/master.tar.gz"
    repo_name = git_url.rsplit('/', 1)[-1]
    repo_path = '/home/ubuntu/repos/' + repo_name + ".tar.gz"

    # Delete Repo if it was previously scanned for a rescan
    # if os.path.exists(repo_path):
    #     shutil.rmtree(repo_path)
    
    #Clone to repos folder TODO delete when done scanning?
    os.system('wget -O {} "{}"'.format(repo_path, url))

    # Run oneshot
    output = os.popen('dosocs2 oneshot ' + repo_path).read()
    return output, 201
 