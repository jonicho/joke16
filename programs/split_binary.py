import sys
import os
filename = os.path.splitext(sys.argv[1])[0]
extension = os.path.splitext(sys.argv[1])[1]
f = open(sys.argv[1], "rb")
f_1 = open(filename+".part1"+extension, "wb")
f_2 = open(filename+".part2"+extension, "wb")
even = True
while (byte := f.read(1)):
    if even:
        f_1.write(byte)
    else:
        f_2.write(byte)
    even = not even

if not even:
    print("warning: file had an odd number of bytes!")

f.close()
f_1.close()
f_2.close()
