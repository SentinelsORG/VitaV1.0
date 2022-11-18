from sys import argv

# Defining functions
def little_endian(data):
    data = hex(data)[2:].zfill(8)
    div = []
    for i in range(4):
        div.append(data[2*i:2*i+2])
    data = " ".join(div[::-1])
    return " " + data + " "

# define assbely OPCODES ins hexadecimal
assembly_instruction = {
    'lda' : '2 ',
    'ldb' : '8 ',
    'add' : 'e ',
    'nop' : '0 ',
    'suba': '10 ',
    'sub' : '12 ',
    'sta' : '16 ',
    'halt': 'ff '
}

# Input Source code and output file names
source_code = argv[1]
program_name = argv[2]


# read source code
with open(source_code, 'r') as source:
    prog = source.read()

prog = prog.split()



# build the machine code
temp_str = ""
for item in prog:
    if item in assembly_instruction:
        temp_str += assembly_instruction[item]
    else:
        temp_str += little_endian(int(item))

temp_str = temp_str.split()
clocks = len(temp_str)

program = "v2.0 raw "
for index, item in enumerate(temp_str):
    if (index % 8 == 0):
        temp = program[:-1]
        program = temp + "\n"
    program += item + " "

program = program[:-1]


# write to the output
with open(program_name+".bodimproc", 'w') as programfile:
    programfile.write(program)

print("[+] Compiling completed.")
print("Total Clock Cycles -> {}".format(clocks))