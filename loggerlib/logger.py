

# from config import getConfig
from configlib import getConfig
from loggerlib.pretify import decorate

def testeable(param):
    return param

def logg(msg):
    config = decorate(getConfig())
    print("{config} --> {msg}".format(config=config, msg=msg))
    return msg
