
from configlib.utils import someUtility

def main():
    print("Hello World!")

def getConfig():
    version = someUtility("")
    return {"version": version}


if __name__ == "__main__":
    main()
