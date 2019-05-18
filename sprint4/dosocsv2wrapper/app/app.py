from flask import Flask, request, jsonify, abort
from git import Repo
import git, shutil, os, subprocess

app = Flask(__name__)

def lsremote(url):
    remote_refs = {}
    g = git.cmd.Git()
    for ref in g.ls_remote(url).split('\n'):
        hash_ref_list = ref.split('\t')
        remote_refs[hash_ref_list[1]] = hash_ref_list[0]
    return remote_refs

@app.route('/')
def index():
    return "Hello, World"

@app.route('/oneshot/', methods=['POST'])
def oneshot():
    # Check that it has a git url
    if not request.json or not 'url' in request.json:
        return abort(400)
    
    json_url = request.json["url"]
    response = lsremote(json_url)
    if len(response) < 1:
        return abort(400)

    # TODO Validate url input instead of just assuming it is a .git url
    git_url = json_url.rsplit('.', 1)[0] #Url without .git following
    url = git_url + "/archive/master.tar.gz"
    repo_name = git_url.rsplit('/', 1)[-1]
    repo_path = '/home/ubuntu/repos/' + repo_name + ".tar.gz"

    # Delete Repo if it was previously scanned for a rescan
    # if os.path.exists(repo_path):
    #     shutil.rmtree(repo_path)
    
    #Clone to repos folder TODO delete when done scanning?
    os.system('wget -O {} "{}"'.format(repo_path, url))

    # Run oneshot
    myCmd = os.popen('dosocs2 oneshot ' + repo_path).read()
    return myCmd, 201
    # return "Success " + git_url + " : " + repo_name, 201
 