from flask import Flask, jsonify, request, Response
from functools import wraps
from werkzeug.routing import Rule
from optparse import OptionParser
from pprint import pprint
import time
import requests

VERBOSE = 'verbose'
BASIC_AUTH = 'basic_auth'
AUTH_USERNAME = 'auth_username'
AUTH_PASSWORD = 'auth_password'

config = {
    BASIC_AUTH: False,
    VERBOSE: False
}

app = Flask(__name__)

def runtest(url):
    r  = requests.get(url)
    data = r.json()
    base_url = data["base_url"]
    if base_url == url:
        return True, "base_url is compliant"
    else:
        return False, "base_url != {url} | {base_url}".format(url=url, base_url=base_url)


@app.route('/runtests')
def echo():

    data = {}
    data["services"] = {}
    data["services"]["echo"] = {}
    data["services"]["pet"] = {}
    data["services"]["reflector"] = {}
    data["status"] = {}
    ## run test echo
    echo_pass, echo_msg = runtest("http://echo.echo.svc.cluster.local/echo")
    ## run test pet
    pet_pass, pet_msg = runtest("http://pet.pet.svc.cluster.local/pet")
    ## run test reflector
    reflector_pass, reflector_msg = runtest("http://reflector.reflector.svc.cluster.local/reflector")
    
    data["status"]["success"] = echo_pass and pet_pass and reflector_pass
    data["status"]["messages"] = [echo_msg, pet_msg, reflector_msg]
    
    response = jsonify(data)
    response.status_code = 200
    return response

def main():
    parser = OptionParser()
    parser.add_option('--port', dest='port', default=5000, help='port to run server on - default 5000')
    parser.add_option('--host', dest='host', default='0.0.0.0', help='host to bind server on - default 0.0.0.0')
    parser.add_option('--auth', dest='auth', help='basic authentication credentials, should be passed in like "username:password"')
    parser.add_option('-v', '--verbose', dest='verbose',
        default=False, action='store_true', help='increased verbosity - outputs response to console')
    parser.add_option('--debug', dest='debug',
        default=False, action='store_true', help='enable debug mode in flask')

    (options, args) = parser.parse_args()

    config[VERBOSE] = options.verbose

    if options.auth:
        username, password = options.auth.split(':')
        if username is None or password is None:
            parser.error('Invalid auth credentials {0}'.format(options.auth))

        config[BASIC_AUTH] = True
        config[AUTH_USERNAME] = username
        config[AUTH_PASSWORD] = password

    app.debug = options.debug
    app.run(port=int(options.port), host=options.host)

if __name__ == '__main__':
    main()


