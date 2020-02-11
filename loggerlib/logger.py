

# from config import getConfig
from configlib import getConfig
from loggerlib.pretify import decorate

def testeable(param):
    return param

def logg(msg):
    config = getConfig()
    if config["decorate"]:
        msg = decorate(msg)
    print(msg)
    return msg
