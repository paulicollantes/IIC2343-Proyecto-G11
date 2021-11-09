from iic2343 import Basys3
import sys

DICC = {
        "MOV": {
            "A,B": 0x00,
            "B,A": 0x01,
            "A,Lit": 0x02,
            "B,Lit": 0x03,
            "A,Dir": 0x04,
            "B,Dir": 0x05,
            "Dir,A": 0x06,
            "Dir,B": 0x07,
            "A,(B)": 0x3F,
            "B,(B)": 0x40,
            "(B),A": 0x41,
            "(B),Lit": 0x42
        },
        "ADD": {
            "A,B": 0x08,
            "B,A": 0x09,
            "A,Lit": 0x0A,
            "B,Lit": 0x0B,
            "A,Dir": 0x0C,
            "B,Dir": 0x0D,
            "Dir,": 0x0E,
            "A,(B)": 0x43,
            "B,(B)": 0x44,
        },
        "SUB": {
            "A,B": 0x0F,
            "B,A": 0x10,
            "A,Lit": 0x11,
            "B,Lit": 0x12,
            "A,Dir": 0x13,
            "B,Dir": 0x14,
            "Dir,": 0x15,
            "A,(B)": 0x45,
            "B,(B)": 0x46,
        },
        "AND": {
            "A,B": 0x16,
            "B,A": 0x17,
            "A,Lit": 0x18,
            "B,Lit": 0x19,
            "A,Dir": 0x1A,
            "B,Dir": 0x1B,
            "Dir,": 0x1C,
            "A,(B)": 0x47,
            "B,(B)": 0x48,
        },
        "OR": {
            "A,B": 0x1D,
            "B,A": 0x1E,
            "A,Lit": 0x1F,
            "B,Lit": 0x20,
            "A,Dir": 0x21,
            "B,Dir": 0x22,
            "Dir,": 0x23,
            "A,(B)": 0x49,
            "B,(B)": 0x4A,
        },
        "XOR": {
            "A,B": 0x24,
            "B,A": 0x25,
            "A,Lit": 0x26,
            "B,Lit": 0x27,
            "A,Dir": 0x28,
            "B,Dir": 0x29,
            "Dir,": 0x2A,
            "A,(B)": 0x4B,
            "B,(B)": 0x4C,
        },
        "NOT": {
            "A,A": 0x2B,
            "B,A": 0x2C,
            "Dir,A": 0x2D,
            "(B),A": 0x4D,
        },
        "SHL": {
            "A,A": 0x2E,
            "B,A": 0x2F,
            "Dir,A": 0x30,
            "(B),A": 0x4E,
        },
        "SHR": {
            "A,A": 0x31,
            "B,A": 0x32,
            "Dir,A": 0x33,
            "(B),A": 0x4F,
        },
        "INC": {
            "A,": 0x34,
            "B,": 0x35,
            "Dir,": 0x36,
            "(B),": 0x50
        },
        "DEC": { "A,": 0x37 },
        "CMP": {
            "A,B": 0x38,
            "A,Lit": 0x39,
            "A,Dir": 0x3A,
            "A,(B)": 0x51,
        },
        "JMP": { "Ins,": 0x3B },
        "JEQ": { "Ins,": 0x3C },
        "JNE": { "Ins,": 0x3D },
        "JGT": { "Ins,": 0x52 },
        "JGE": { "Ins,": 0x53 },
        "JLT": { "Ins,": 0x54 },
        "JLE": { "Ins,": 0x55 },
        "JCR": { "Ins,": 0x56 },
        "NOP": { ",": 0x3E },
        "PUSH": {
            "A,": 0x57,
            "B,": 0x58,
        },
        "POP": {
            "A,": 0x59,
            "B,": 0x5A,
        },
        "CALL": { "Ins,": 0x5B },
        "RET": { ",": 0x5C},
        "incSP" : {",":0x7E},
        "decSP" : {",",0x7F},
    }

class Assembler:

    def __init__(self):
        self.lines = []
        self.variables = {}
        self.pos_variables = {}
        self.code = []
        self.labels = {}

    def save_vars(self, path):
        #Leer txt
        with open(path, "r") as file:
            i = 0
            v = 0
            for line in file:
                self.lines.append(line.strip())
            for line in self.lines:
                #print(line.strip())
                line_ins = line.split("//")
                if line_ins[0].strip() == "DATA:":
                    i += 1
                elif line_ins[0].strip() == "CODE:":
                    i += 1
                    return i + 1
                else:
                    var = line.split("//")
                    for l in var:
                        l.strip()
                    var2 = var[0].split(" ")
                    if var2 != "" and len(var2) > 1:
                        nombre = var2[0]
                        valor = []
                        valor.append(var2[-1])
                        self.variables[nombre] = valor
                        self.pos_variables[nombre] = v
                        v += 1
                        i += 1
                    else:
                        if len(var) == 1 and var[0]:
                            self.variables[nombre].append(var[0])
                            v += 1
                            i += 1
                        else:
                            i += 1
    

    def save_code(self, code_start):
        with open(path, "r") as file:
            i = 0
            for line in file:
                i += 1
                if i >= code_start:
                    if line != "\n":
                        codeline = line.split("//")
                        for l in codeline:
                            l.strip()
                        if codeline[0] != "":
                            self.code.append(codeline[0].strip("\n")) # REVISAR - No faltaría este strip arriba? (save_vars)
                    #print(self.code)
        
    def save_labels(self):
        i = 0
        for line in self.code:
            line = line.strip()
            if len(line) > 0 and line[-1] == ":":
                label = line.strip(":")
                pos = i
                self.labels[label] = pos
                i += 1
            else:
                i += 1
        

    def separate(self):
        instructions = []
        for line in self.code:
            line = line.strip()
            if len(line) > 0 and line[-1] == ":":
                instructions.append(["NOP", "", "", "", ""])
            else:
                inst = line[0:3]
                arguments = line[3:].split(",")
                #print(arguments)
                for l in arguments:
                    l.strip()
                arg_1 = arguments[0]
                type_1, arg_1 = self.clean_arg(arg_1, inst)
                a1 = self.variables.get(arg_1)
                if type_1 == "Dir":
                    if a1:
                        arg_1 = self.variables[arg_1][0]
                else:
                    if a1:
                        arg_1 = self.pos_variables[arg_1]
                l1 = self.labels.get(arg_1)
                if l1:
                    arg_1 = self.labels[arg_1]
                if len(arguments) > 1:
                    arg_2 = arguments[1]
                    type_2, arg_2 = self.clean_arg(arg_2, inst)
                    a2 = self.variables.get(arg_2)
                    if type_1 == "Dir":
                        if a2:
                            arg_2 = self.variables[arg_2][0]
                    else:
                        if a2:
                            arg_2 = self.pos_variables[arg_2]
                    l2 = self.labels.get(arg_2)
                    if l2:
                        arg_2 = self.labels[arg_2] 
                else:
                    type_2 = ""
                    arg_2 = ""             
                lineinst = [inst, type_1, type_2, arg_1, arg_2]
                instructions.append(lineinst)
        return instructions
            

    def clean_arg(self, arg, inst):
        lIns = ["JMP", "JEQ", "JWE", "JGT", "JGE", "JLT", "JLE", "JCR", "CALL"]
        valor = arg.strip()
        if valor[0] == "(":
            if arg.strip("( )") == "B":
                valor = "(B)"
                tipo = "(B)"
            else:
                valor = arg.strip("( )")
                tipo = "Dir"
        elif valor == "A":
            tipo = "A"
        elif valor == "B":
            tipo = "B"
        elif inst in lIns:
            tipo = "Ins"
        else:
            tipo = "Lit"
        return (tipo, valor)

    def formatter(self, literal=''):
        if not literal: # when empty ''
            literal = 0
        elif isinstance(literal, int): # when it's already number
            pass
        elif literal[-1] == 'd' or literal[-1] not in ['b', 'd', 'h']: # when it's a string number
            literal = int(literal.replace('d',''))
        elif literal[-1] == 'b': 
            literal = int('0b'+literal.replace('b', ''),2)
        elif literal[-1] == 'h':
            literal = int('0x'+literal.replace('h', ''),16)
        if literal < 0:
            raise ValueError("Negative numbers not allowed")
        return hex(literal)
        #return (literal).to_bytes(2, byteorder='big', signed=False)
    
    def getByteArray(self, instruction = 'JMP', type1='', type2='', elemento1='', elemento2=''):
        global DICC
        types = ['Lit', 'Ins', 'Dir']
        emptyBits = 0x000
        operands = f'{type1},{type2}'
        opcode = DICC[instruction][operands]# .to_bytes(2, byteorder='big', signed=False)
        if type1 in types:
            mostSignificatives = self.formatter(elemento1)
        elif type2 in types:
            mostSignificatives = self.formatter(elemento2)
        else:
            mostSignificatives = self.formatter('')
        bytesArray = []
        bytesArray.append([mostSignificatives , emptyBits , opcode])
        
        if instruction == 'RET':
            bytesArray=[]
            opcode = [DICC['incSP'][operands],DICC[instruction][operands]]
            mostSignificatives = self.formatter('')
            for a in 2:
                bytesArray.append([mostSignificatives , emptyBits , opcode[a]])
        
        elif instruction == 'POP':
            mostSignificatives= self.formatter('')
            bytesArray=[]
            opcode = [DICC['incSP'][','], DICC[instruction][operands]]
            for a in 2:
                bytesArray.append([mostSignificatives , emptyBits , opcode[a]])


        return bytesArray

    def instructionsToBytes(self, instructions):
        bytesArray = []
        for line in instructions:
            print('prr', line)
            bytesArray += self.getByteArray(*line)
        return bytesArray
        



path = sys.argv[1]
assembler = Assembler()
code_start = assembler.save_vars(path)
assembler.save_code(code_start)
assembler.save_labels()
#print(assembler.variables)
#print(assembler.pos_variables)
#print(assembler.labels)

instructions = assembler.separate()

#for l in instructions:
#    print(l)
instInBytes = assembler.instructionsToBytes(instructions)
#for l in instInBytes:
#    print(l)

rom_programmer = Basys3()
print('Puertos:', end=' ')
for i in rom_programmer.available_ports:
    print(i.device, end=' -> ') # Revisar admin dispositivos de Win y seleccionar el USB
i = 0
for line in instInBytes:
    if len(line) > 1:
        for llave, valor in assembler.labels.items():
            if valor > i:
                assembler.labels[llave] += 1
    for byteArray in line:
        print(line)
        rom_programmer.write(i, line)
        i += 1
rom_programmer.begin(4) # Colocar acá la posición que le correspondería
rom_programmer.end()
