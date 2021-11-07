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
    }

class Assembler:

    def __init__(self):
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
                #print(line.strip())
                if line.strip() == "DATA:":
                    i += 1
                elif line.strip() == "CODE:":
                    i += 1
                    return i + 1
                else:
                    var = line.split("//")
                    for l in var:
                        l.strip()
                    if var[0] != "":
                        var[0].strip(" ")
                        variable = var[0].split(" ")
                        nombre = variable[0]
                        valor = variable[1]
                        self.variables[nombre] = valor
                        self.pos_variables[nombre] = v
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
                            self.code.append(codeline[0].strip("\n"))
                    print(self.code)
        
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
                instructions.append(["NOP", None, None, None, None])
            else:
                inst = line[0:3]
                arguments = line[3:].split(",")
                for l in arguments:
                    l.strip()
                arg_1 = arguments[0]
                type_1, arg_1 = self.clean_arg(arg_1)
                if type_1 == "Dir":
                    try:
                        self.variables[arg_1]
                        arg_1 = self.variables[arg_1]
                    except KeyError:
                        pass
                else:
                    try:
                        self.variables[arg_1]
                        arg_1 = self.pos_variables[arg_1]
                    except KeyError:
                        pass
                try:
                    self.labels[arg_1]
                    arg_1 = self.labels[arg_1]
                except KeyError:
                    pass
                if len(arguments) > 1:
                    arg_2 = arguments[1]
                    type_2, arg_2 = self.clean_arg(arg_2)
                    if type_1 == "Dir":
                        try:
                            self.variables[arg_2]
                            arg_2 = self.variables[arg_2]
                        except KeyError:
                            pass
                    else:
                        try:
                            self.variables[arg_2]
                            arg_2 = self.pos_variables[arg_2]
                        except KeyError:
                            pass
                    try:
                        self.labels[arg_2]
                        arg_2 = self.labels[arg_2]
                    except KeyError:
                        pass  
                else:
                    type_2 = None
                    arg_2 = None             
                lineinst = [inst, type_1, type_2, arg_1, arg_2]
                instructions.append(lineinst)
        return instructions
            

    def clean_arg(self, arg):
        valor = arg.strip()
        if valor[0] == "(":
            valor = arg.strip("( )")
            tipo = "Dir"
        elif valor == "A":
            tipo = "A"
        elif valor == "B":
            tipo = "B"
        else:
            tipo = "Lit"
        return (tipo, valor)

    def formatter(self, literal=''):
        if not literal:
            literal = 0
        elif isinstance(literal, int):
            pass
        elif literal[-1] == 'd' or literal[-1] not in ['b', 'd', 'h']:
            literal = int(literal.replace('d',''))
        elif literal[-1] == 'b': 
            literal = int('0b'+literal.replace('b', ''),2)
        elif literal[-1] == 'h':
            literal = int('0x'+literal.replace('h', ''),16)
        if literal < 0:
            raise ValueError("Negative numbers not allowed")
        return (literal).to_bytes(2, byteorder='big', signed=False)
    
    def getByteArray(self, instruction = 'JMP', type1='', type2='', elemento1='', elemento2=''):
        global DICC
        types = ['Lit', 'Ins', 'Dir']
        emptyBits = bytearray(0x003)
        operands = f'{type1},{type2}'
        opcode = DICC[instruction][operands].to_bytes(2, byteorder='big', signed=False)
        if type1 in types:
            mostSignificatives = self.formatter(type1)
        elif type2 in types:
            mostSignificatives = self.formatter(type2)
        else:
            mostSignificatives = self.formatter('')
        
        return mostSignificatives + emptyBits + opcode

    def intructionsToBytes (self, instructions):
        byteArray = []
        for line in instructions:
            byteline = self.getByteArray(*line)
            byteArray.append(byteline)
        return byteArray
        



path = sys.argv[1]
assembler = Assembler()
code_start = assembler.save_vars(path)
assembler.save_code(code_start)
assembler.save_labels()
instructions = assembler.separate()
#print(assembler.variables)
#print(assembler.pos_variables)
#print(assembler.labels)
#for l in instructions:
#    print(l)

""" instInBytes = assembler.intructionsToBytes(instructions)
rom_programmer = Basys3()
rom_programmer.begin()
for line in instInBytes:
    rom_programmer.write(0, line)
rom_programmer.end() """
