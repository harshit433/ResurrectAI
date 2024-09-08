from flask import Flask

app = Flask(__name__)

@app.route('/')

def hello():

    return "<h1>Hello World!</h1>" \
           "\nThis is my introduction to Flask!" \
           "\nI can write a lot of things on this page.\nLet's get started!"



if __name__ == '__main__':

   app.run()
