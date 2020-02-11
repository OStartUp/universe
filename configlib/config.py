
from configlib.utils import someUtility

def main():
    print("Hello World!!!")

def getConfig():
    version = someUtility("")
    return {"version": version, "decorate": True}


if __name__ == "__main__":
    main()
