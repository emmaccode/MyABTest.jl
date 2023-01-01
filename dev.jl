using Pkg; Pkg.activate(".")
using Toolips
using Revise
using MyABTest

IP = "127.0.0.1"
PORT = 8000
MyABTestServer = MyABTest.start(IP, PORT)
