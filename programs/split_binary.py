import sys
import os
filename = os.path.splitext(sys.argv[1])[0]
extension = os.path.splitext(sys.argv[1])[1]
f = open(sys.argv[1], "rb")
f_0 = open(filename+".0"+extension, "wb")
f_1 = open(filename+".1"+extension, "wb")
even = True
while (byte := f.read(1)):
    if even:
        f_1.write(byte)
    else:
        f_0.write(byte)
    even = not even

if not even:
    print("warning: file had an odd number of bytes!")

f.close()
f_0.close()
f_1.close()
