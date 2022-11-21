from sys import argv
from subprocess import call

ram_add_width = 16
ram_data_width = 8

high_end = 2**16 - 1

assembly = []

allocated_vars = []
allocated_var_addrs = []

var_types = ['int']

source = argv[1]
out_file_name = argv[2]

# opening the source files
with open(source, 'r') as source:
    content = source.read()

# removing comments
#####################################################################################################################################################
new_cont = ""
single_line_comment_latch = False
multi_line_comment_latch = False

for index, char in enumerate(content):
    
    # identifiy comment start point
    if char == '/':
        if content[index + 1] == '/':
            single_line_comment_latch = True
        elif content[index + 1] == '*':
            multi_line_comment_latch = True
            
    if (not single_line_comment_latch) and (not multi_line_comment_latch):
        new_cont += char
            
            
    # identify comment end point:
    if single_line_comment_latch:
        if char == '\n':
            print
            single_line_comment_latch = False
    if multi_line_comment_latch:
        if char == '/' and content[index-1] == '*':
            multi_line_comment_latch = False
            
content = new_cont.replace('\n', '')

########################################################################################################################################################

class variable_definition:
    def __init__(self, var_type, definition):
        self.name = definition.split('=')[0]
        self.var_type = var_type
        self.definition = "".join(definition.split('=')[1:])
        self.numbers =  []
        self.operations = []
        self.op_codes = ['+', '-']
        
        self.extract()
        
    def extract(self):
        accum = ""
        for index,char in enumerate(self.definition):
            if char in self.op_codes: # then it is a operations
                self.operations.append(char)

                if accum.strip() != "":
                    self.numbers.append(accum.strip())
                accum = ""
            else:
                accum += char

        if accum.strip() != "":
            self.numbers.append(accum.strip())
        
        
    def integer_allocation(self):
        allocated_vars.append(self.name) # store variable name

        if (len(allocated_var_addrs) == 0):
            allocated_var_addrs.append(high_end - 3)
        else:
            allocated_var_addrs.append(allocated_var_addrs[-1] - 4) # store vairable address in RA

        self.exp_to_assem(allocated_var_addrs[-1])

    def exp_to_assem(self, result_addr):
        opr = {
            '+':'add',
            '-':'sub'
        }

        first_op_done = False

        if len(self.operations):
            for index, number in enumerate(self.numbers):
                if index == 0:
                    assembly.append(f'lda {number}')
                else:
                    if index % 2 == 0 and not first_op_done:
                        assembly.append(opr[self.operations.pop(0)])
                        first_op_done = True
                    else:
                        if first_op_done:
                            assembly.append(opr[self.operations.pop(0)])
                    assembly.append(f'ldb {number}')

            assembly.append(opr[self.operations.pop(0)])
            assembly.append(f'sta {result_addr}')
        else:
            if len(self.numbers):
                assembly.append(f'lda {self.numbers[0]}')
                assembly.append(f'sta {result_addr}')
            else:
                assembly.append('lda -1')
                assembly.append(f'sta {result_addr}')

##########################################################################################################################################################

# truncating the program
trunks = {}
trunk_names = []
trunk_start_indexes = []

trunk_start_count = -1

for index, char in enumerate(content):
    if char == '{':
        # now search for name until hit ;
        try:
            counter = 1
            while content[index - counter] != ';' and index - counter > 0:
                counter += 1
            
            trunk_name = content[index-counter:index] # extracting trunk name
            trunk_names.append(trunk_name) # appending trunk name to the list
            # get start and end of the trunk
            trunk_start_count += 1 # incrementing trunks
            trunk_start_indexes.append(index) # record trunk starts
            
        except:
            print(f"Syntax error near {index}")
    
    if char == "}":
        if len(trunk_start_indexes) <= 0:
            print(f"Syntax error near {index}")
            exit()
            
        trunks[trunk_names[trunk_start_count]] = content[trunk_start_indexes[trunk_start_count] + 1:index]


##########################################################################################################################################################

# for now get only first trunk

# do variable definition
variables = []
for line in trunks[trunk_names[0]].split(';'):
    temp_line = line.strip()
    
    if len(temp_line): # ignore empty lines
        #checking for declarations
        if temp_line.split()[0] in var_types:
            splitted = temp_line.split()
            var_type = splitted[0]
            var_def = " ".join(splitted[1:])
            
            variables.append(variable_definition(var_type, var_def))

##############################################################################################################################################################

# now compile the variables
for variable in variables:
    variable.integer_allocation()
    
assembly.append('halt')



with open(out_file_name + '.assem', 'w') as out_assem:
    out_assem.write('\n'.join(assembly))

print('Stored Variables')
print('------------------------------')
for index, item in enumerate(allocated_vars):
    print('{} --> {}'.format(item, hex(allocated_var_addrs[index])))




##############################################
call('python compiler.py {} {}'.format(out_file_name + '.assem', out_file_name), shell=True)