import numpy as np
import matplotlib.pyplot as plt
#ahmed okab
#importing numpy and matplotlib to help create the coefficient arrays and plot


NumOfTaps = 8

#converting signed binary to signed decimal
def binarytodecimal(x) -> int: #x is the binary string
    n = len(x)
    value = int(x, 2);
    if x[0] == "1":
        value -= (1 << n) #interpret whole thing as unsigned
    return value  #if msb is 1, subtract 2^n from it

    
    
NumOfTaps = 8
cobit = 8 #coefficient bit numbers
filterbit = 16 # convert input to 16 bit signed

#output bit width will be 32 bits
outputbit = 24 


b = np.ones(NumOfTaps) / NumOfTaps #this creates an array of 1/8 each

coefficientbit = np.binary_repr(int(b[0] * (2 ** (cobit-1))),cobit) #turning into 8 bit form
# 1/8 * 2 to the power of 7  to perform fixed binary scalng


# we will use binary representation of 1/8 in our verilog code

timeVector = np.linspace(0, 2*np.pi, 200)
output = np.sin(2*timeVector) + np.cos(3*timeVector) + 0.3*np.random.randn(timeVector.size)



binlist = []
for num in output:
    binlist.append( np.binary_repr(int(num * (2 ** (cobit-1))),filterbit) )

#creating the list of 16bit binary numbers that represent the wave    

with open('input.data', 'w') as f:
    for num in binlist:
        f.write(num + '\n')
        
#storing the numbers in the file

#run vivado code

#reading filtered values, storing binary representation 
#plotting filtered results

readValues = []

with open("saved.data") as file2:
    for line in file2:
        readValues.append(line.rstrip('\n'))

print(readValues)
convertedValues = []

for binaryval in readValues:
    convertedValues.append( binarytodecimal(binaryval) / (2 ** (2* (cobit-1)))) #used same scale twice so put 2 in the power. used scale for coefficient and input samples

plt.figure(figsize=(10,5))
plt.plot(output, label="Noisy Input (Python float)", alpha=0.6)
plt.plot(convertedValues, label="Filtered Output (Verilog)", linewidth=2)
plt.xlabel("Sample Index")
plt.ylabel("Amplitude")
plt.title("FIR Filter Output vs Input")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()


#There is some delay after plotting, this is expected. An 8 tab filter is used, causing this delay, data is smooth