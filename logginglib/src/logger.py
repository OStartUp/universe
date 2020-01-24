

# from config import getConfig
from config.src import getConfig

def testeable(param):
    return param

def logg(msg):
    config = getConfig() 
    print(f"{config} - {msg}")
