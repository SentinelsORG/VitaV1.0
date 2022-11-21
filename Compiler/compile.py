from sys import argv
from subprocess import call

ram_add_width = 16
ram_data_width = 8

high_end = 2**16 - 1

assembly = []

allocated_vars = []
allocated_var_addrs = []

def integer_allocation(variable):
    allocated_vars.append(variable[1]) # store variable name
    
    if (len(allocated_var_addrs) == 0):
        allocated_var_addrs.append(high_end - 3)
    else:
        allocated_var_addrs.append(allocated_var_addrs[-1] - 4) # store vairable address in RA
    
    exp_to_assem(variable[3:], allocated_var_addrs[-1])

def exp_to_assem(expression, result_addr):
    opr = {
        '+':'add',
        '-':'sub'
    }
    
    operations = []
    numbers = []
    for item in expression:
        try:
            numbers.append(int(item))
        except:
            operations.append(item)
    
    first_op_done = False
    
    for index, number in enumerate(numbers):
        if index == 0:
            assembly.append(f'lda {number}')
        else:
            if index % 2 == 0 and not first_op_done:
                assembly.append(opr[operations.pop(0)])
                first_op_done = True
            else:
                if first_op_done:
                    assembly.append(opr[operations.pop(0)])
            assembly.append(f'ldb {number}')
    
    assembly.append(opr[operations.pop(0)])
    assembly.append(f'sta {result_addr}')


source = argv[1]
out_file_name = argv[2]

with open(source, 'r') as source_file:
    content = source_file.read()
    
content = content.split('\n')

for line in content:
    temp = line.split(" ")
    if temp[0] == 'int':
        integer_allocation(temp)
        
assembly.append('halt')

with open(out_file_name + '.assem', 'w') as out_assem:
    out_assem.write('\n'.join(assembly))


print('Stored Variables')
print('------------------------------')
for index, item in enumerate(allocated_vars):
    print('{} --> {}'.format(item, hex(allocated_var_addrs[index])))




##############################################
call('python compiler.py {} {}'.format(out_file_name + '.assem', out_file_name), shell=True)