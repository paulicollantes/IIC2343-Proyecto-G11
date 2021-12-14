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
                        valor += var_value
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
            new_var = var.strip("\"").strip("\'")
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
                pass
                #instructions.append(["NOP", "", "", "", ""])
            else:
                instrucc = line.split(" ")
                inst = instrucc[0]
                arguments = [l.strip() for l in instrucc[-1].split(",")]
                #print("PRRRRRR, ", line, end="--->")
                #print(arguments)
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
                    type_2 = "" #Esto es necesario?
                    arg_2 = ""          
                lineinst = [inst, type_1, type_2, arg_1, arg_2]
                instructions.append(lineinst)
        return instructions
            

    def clean_arg(self, arg, inst):
        lIns = ["JMP", "JEQ", "JWE", "JGT", "JGE", "JLT", "JLE", "JCR", "CALL"]
        valor = arg.strip()
        #print("AAAHHH, ", valor)
        if valor[0] == "(":
            if arg.strip("( )") == "B":
                valor = "B" #Esto está mal creo, pero no es el problema
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
        elif inst == "RET":
            tipo = ""
            valor = ""
        else:
            tipo = "Lit"
        return (tipo, valor)

    def instructionsToBytes(self, instructions):
        bytesArray = []
        for line in instructions:
            bytesArray += getWordArray(*line)
        return bytesArray
        
if __name__ == '__main__':
    debug = True
    tests = ['./tests/Test 0 - Mínimo.txt',
             './tests/Test 1 - Ram y Status.txt',
             './tests/Test 2 - Indirecto y Stack.txt',
             './tests/Test 3 - Entrada y Salida.txt'] 

    paths = tests if debug else [sys.argv[1]]
    for path in paths:
        assembler = Assembler()
        code_start = assembler.save_vars(path)
        assembler.save_code(code_start)
        assembler.save_labels()
        #print(assembler.variables)
        #print(assembler.pos_variables)
        #print(assembler.labels)

        instructions = assembler.separate()
        #print("Instrucciones :")
        #for l in instructions:
        #    print(l)
        #print("Fin instrucciones")
        instInBytes = assembler.instructionsToBytes(instructions)
        #for l in instInBytes:
        #    print(l)
        #print(instInBytes)
        
        rom_programmer = Basys3()
        print('Puertos:', end=' ')
        for i in rom_programmer.available_ports:
            print(i) # Revisar admin dispositivos de Win y seleccionar el USB
        i = 0
        rom_programmer.begin(2) # Colocar acá la posición que le correspondería
        for line in instInBytes:
            if len(line) > 1:
                for llave, valor in assembler.labels.items():
                    if valor > i:
                        assembler.labels[llave] += 1
            for byteArray in line:
                print(line)
                rom_programmer.write(i, line)
                i += 1
        rom_programmer.end()
        
        time.sleep(50)