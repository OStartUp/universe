

# from config import getConfig
from config.src import getConfig

def logg(msg):
    config = getConfig() 
    print(f"{config} - {msg}")
