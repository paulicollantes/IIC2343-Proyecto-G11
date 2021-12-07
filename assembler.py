from iic2343 import Basys3
import sys
from dict_and_formatter import DICC, getWordArray
import os
import time

## TO DO
## Arreglar avance punteros 

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
                if line_ins[0].strip() == "DATA:" or line_ins[0].strip() == "":
                    i += 1
                elif line_ins[0].strip() == "CODE:":
                    i += 1
                    return i + 1
                else:
                    var = [l.strip() for l in line.split("//")]
                    var2 = var[0].split(" ")
                    if var2 != "" and len(var2) > 1:
                        nombre = var2[0]
                        var_value , sum_v = self.valor_to_ascii(var2[-1])
                        valor = [] 
                        valor.append(var_value)
                        self.variables[nombre] = valor
                        self.pos_variables[nombre] = v
                        v += sum_v
                        i += 1
                    else:
                        if len(var) == 1 and var[0]:
                            self.variables[nombre].append(var[0])
                            v += 1
                            i += 1
                        else:
                            i += 1 
    
    def valor_to_ascii(self, var):
        if "\'" in var or "\"" in var:
            new_var = var.strip("\"")
            new_var = new_var.strip("\'")
            var_list = list(new_var)
            if len(var_list) > 1:
                for car in var_list:
                    self.variables[car] = ord(car)
                var_list.append('0')               
            ascii_list = [ord(c) for c in var_list]
            sum_var = len(var_list)
            return (ascii_list, sum_var)
        else:
            new_var = var
            sum_var = 1
        return (new_var, sum_var)

    def save_code(self, code_start):
        with open(path, "r") as file:
            i = 0
            for line in file:
                i += 1
                if i >= code_start:
                    if line != "\n":
                        codeline = [l.strip() for l in line.split("//")]
                        if codeline[0].strip() != "":
                            self.code.append(codeline[0].strip("\n")) # REVISAR - No faltaría este strip arriba? (save_vars)
                    #print(self.code)
        
    """ Llena self labels con sus posiciones. dicc[nombreLabel] = lineaLabel """
    def save_labels(self):
        for pos,line in enumerate(self.code):
            line = line.strip()
            if len(line) > 0 and line[-1] == ":":
                label = line.strip(":")
                self.labels[label] = pos

    def separate(self):
        instructions = []
        for line in self.code:
            line = line.strip()
            if len(line) > 0 and line[-1] == ":":
                pass # instructions.append(["NOP", "", "", "", ""])
            else:
                inst = line[0:3]
                arguments = line[3:].split(",")
                print("PRRRRRR, ", line, end="--->")
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
        print("AAAHHH, ", valor)
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

    def instructionsToBytes(self, instructions):
        bytesArray = []
        for line in instructions:
            bytesArray += getWordArray(*line)
        return bytesArray
        
if __name__ == '__main__':
    #debug = 'todos'
    debug = 'especial'
    #debug = 'input'
    programDevice = True
    tests = ['./tests/Test 0 - Mínimo.txt',
             './tests/Test 1 - Ram y Status.txt',
             './tests/Test 2 - Indirecto y Stack.txt',
             './tests/Test 3 - Entrada y Salida.txt',
             './tests/contador.txt'] 
    if debug == 'input': paths = [sys.argv[1]]
    elif debug=='todos': paths = tests
    elif debug == 'especial': paths=[tests[int(sys.argv[1])]]
    print(paths)
    for path in paths:
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
        print(instInBytes)
        if programDevice:
            rom_programmer = Basys3()
            rom_programmer.begin(4) # Colocar acá la posición que le correspondería
            # ----------------------------bytearray ([par1, par2, par3, par4, par5])
            # -------------------------par5=Opcode, par4 y par3.2 vacio, par3.1 par 2 par 1.2 literal
            # print(rom_programmer.write(0, bytearray([0x00, 0x00, 0x00, 0x00, 0x02])))
            print(rom_programmer.write(1, bytearray([0x00, 0x00, 0x10, 0x00, 0x03])))
            print(rom_programmer.write(2, bytearray([0x00, 0x00, 0x30, 0x00, 0x02])))
            print(rom_programmer.write(3, bytearray([0x00, 0x00, 0x00, 0x00, 0x09])))
            print(rom_programmer.write(4, bytearray([0x00, 0x00, 0x00, 0x00, 0x00])))
            print(rom_programmer.write(5, bytearray([0x00, 0x00, 0x00, 0x00, 0x09])))
            print(rom_programmer.write(6, bytearray([0x00, 0x00, 0x00, 0x00, 0x0F])))
            rom_programmer.end()
            # print(rom_programmer.write(7, bytearray([0x00, 0x00, 0x30, 0x00, 0x09])))

            #print(rom_programmer.write(3, bytearray([0x00, 0x00, 0x70, 0x00, 0x09])))
            #print(rom_programmer.write(4, bytearray([0x00, 0x00, 0x00, 0x00, 0x02])))
            #print(rom_programmer.write(4, bytearray([0x00, 0x01, 0x00, 0x00, 0x3B])))

            #print(rom_programmer.write(4, bytearray([0x00, 0x00, 0x23, 0x00, 0x03])))
            #print(rom_programmer.write(5, bytearray([0x00, 0x00, 0xA3, 0x00, 0x09])))
            #print(rom_programmer.write(6, bytearray([0x00, 0x00, 0x23, 0x00, 0x03])))
            # print(rom_programmer.write(6, bytearray([0x00, 0x01, 0x03, 0x00, 0x3B])))
            #rom_programmer.write(6, bytearray([0x00, 0x00, 0x03, 0x00, 0x09]))
            #rom_programmer.write(7, bytearray([0x00, 0x00, 0x53, 0x00, 0x02]))
            #rom_programmer.write(8, bytearray([0x00, 0x00, 0xA3, 0x00, 0x09]))




            # ---------------------------------------------------------------------
            # --------------------------------------------------------------------
            print('Puertos:', end=' ')
            for i in rom_programmer.available_ports:
                print(i.device, end=' -> ') # Revisar admin dispositivos de Win y seleccionar el USB
            i = 0
            for line in instInBytes:
                if len(line) > 1:
                    for llave, valor in assembler.labels.items():
                        if valor > i:
                            assembler.labels[llave] += 1
                print('linea 205',i, line)
                #rom_programmer.write(i, line)
                i += 1
                #for byteArray in line:
                #    print('linea 206', line)
                #    rom_programmer.write(i, line)
                #    i += 1
                """
                if i%2==0:
                    print('oooo')
                    print(rom_programmer.write(i, bytearray([0x00, 0x00, 0x93, 0x00, 0x02])))
                    print(rom_programmer.write(i+1, bytearray([0x00, 0x00, 0x73, 0x00, 0x03])))
                else:
                    print('eeee')
                    print(rom_programmer.write(i, bytearray([0x00, 0x00, 0x83, 0x00, 0x02])))
                    print(rom_programmer.write(i+1, bytearray([0x00, 0x00, 0x43, 0x00, 0x03])))
                i += 1"""

        
        #time.sleep(5)