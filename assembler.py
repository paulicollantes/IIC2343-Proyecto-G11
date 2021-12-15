from iic2343 import Basys3
import sys
from dict_and_formatter import DICC, getWordArray, values_to_ascii, number_formatter
import os
import time

## Instrucciones de 2 ciclos:
## POP, RET
## Igualmente tienen su propio opcode que hace la segunda acción (no la incSP que es la primera)

class Assembler:
    def __init__(self):
        self.lines = []
        self.variables = {}
        self.pos_variables = {}
        self.code = []
        self.labels = {}

        self.data_instructions = []
        self.code_instructions = []
        self.position_variables = {}
        self.position_labels = {}
        self.data_lines = []
        self.code_lines = []
        self.bytesArray = []
    
    def execute_test(self, path):
        print("1.- Primero, a guardar las lineas del test de manera separada")
        self.save_file_lines(path)
        print("2.- Luego, gestionar las líneas para poder trabajarlas (DATA)")
        self.manage_data()
        print("3.- Luego, parsear las líneas para poder trabajarlas (CODE)")
        self.manage_code()
        print("4.- Ahora, traducimos nuestras instrucciones a lenguaje de máquina")
        self.instructionsToBytes()
        print("5.- Ahora, finalmente, a sobreescribir la ROM")
        self.writeROM()


    def save_file_lines(self, path):
        data_zone = False
        code_zone = False
        with open(path, 'r') as file:
            for i, line in enumerate(file):
                if '//' in line:
                    line = line.split('//')[0] # Quita los comentarios
                line = line.strip()            # Quita los espacios que redundan
                if line == "DATA:":
                    data_zone = True
                elif line == "CODE:":
                    code_zone = True
                    data_zone = False
                elif not line:
                    continue                    # Si la línea no tiene nada, se continua
                if data_zone and line != "DATA:": self.data_lines.append(line)
                elif code_zone and line != "CODE:": self.code_lines.append(line)
                else: print(f'Que curioso lo que pasó en #{i} con -> ', line)
        return 'Terminamos de guardar las líneas del archivo'
    
    def manage_data(self):
        ram = []
        for line in self.data_lines:
            splitted_line = line.split()
            if len(splitted_line) > 1:                                # Realmente debería tener máximo 2, pero igual
                variable = splitted_line[0]
                value = splitted_line[1]
                self.position_variables[variable] = len(ram)     # Guarda el puntero de su posición en la RAM (address)
            elif len(splitted_line) == 1:
                # variable no ha sido redefinida, por lo que sigue igual
                value = splitted_line[0]
            else:
                print("No deberían haber lines vacías aquí")
            
            if value[0] == "'":
                values = values_to_ascii(value) # Sería un string del tipo 'c string'
            elif value[0] == '"':
                values = values_to_ascii(value) + [0]# Sería un string del tipo "cero string"
            else:
                values = [value]
            ram += values      
        for pos, valor in enumerate(ram):
            instructions = [
                { 'operation': 'MOV', 'elem1': 'A', 'elem2': valor, 'type1': 'A', 'type2': 'Lit', },
                { 'operation': 'MOV', 'elem1': pos, 'elem2': 'A', 'type1': '(Dir)', 'type2': 'A', },
            ]
            self.data_instructions += instructions
        return 'Terminamos de guardar las instrucciones necesarias para guardar la Data'
    
    def manage_code(self):
        for line in self.code_lines:
            if ':' in line:             # Sería un label
                label = line[:line.index(':')].strip() # Se queda con lo anterior al ':'
                # La posición del label apuntará a la siguiente línea, lo que corresponde, pero considerando el piso extra de bytesArray por la Data
                self.position_labels[label] = len(self.code_instructions) + len(self.data_instructions) 
            elif not line: 
                print("No deberían haber lines vacías aquí")
            else:
                self.data_instructions += self.format_line(line)

        # Para guardar las posiciones-address de las instrucciones para los jumps
        for i, instruction in enumerate(self.data_instructions):
            if instruction['type1'] == 'Label-Ins':
                self.data_instructions[i]['elem1'] =  self.position_labels[instruction['elem1']]
        return 'Terminamos de guardar las instrucciones y labels necesarios para guardar el Code'

    def format_line(self, line):
        instructions = []
        splitted_line = line.split()
        operation = splitted_line[0]
        operands = ''.join(splitted_line[1:])

        if operation in ('POP', 'RET'):
            instructions.append({ 'operation': 'incSP', 'elem1': None, 'elem2': None, 'type1': None, 'type2': None, })
        
        if not operands: # RET, NOP
            elem1, type1 = None, None
            elem2, type2 = None, None
        elif not ',' in operands: # Jumps, INC, DEC, PUSH, POP, CALL, Otros
            elem1, type1 = self.parser_single_operand(operands)
            elem2, type2 = None, None
        else:
            print('-->', line, self.position_variables)
            operand1, operand2 = operands.split(',')
            elem1, type1 = self.parser_dual_operand(operand1)
            elem2, type2 = self.parser_dual_operand(operand2)

        instructions.append({
            'operation': operation,
            'elem1': elem1, 'elem2': elem2,
            'type1': type1, 'type2': type2,
            })
        return instructions

    def parser_single_operand(self, operand):
        if operand == 'A':                         # INC A
            elem1 = 'A'
            type1 = 'A'
        elif operand == 'B':                       # INC B
            elem1 = 'B'
            type1 = 'B'
        elif operand == '(B)':
            elem1 = '(B)'
            type1 = '(B)'
        elif '(' in operand:                       # MOV (dir)
            variable = operand[1:-1]               # Para quitar los paréntesis
            if self.position_variables.get(variable, 'F') != 'F':                                  #
                elem1 = self.position_variables[variable] # Para quitar los paréntesis
                type1 = '(Dir)'
            else:                                  # MOV A,(Lit)
                elem1 = number_formatter(variable) 
                type1 = '(Dir)'
        else:
            elem1 = operand # self.position_labels[operand] # JMP label
            type1 = 'Label-Ins'
        return elem1, type1

    def parser_dual_operand(self, operand):
        if operand == 'A':                         #
            elem = 'A'
            type_ = 'A'
        elif operand == 'B':                       #
            elem = 'B'
            type_ = 'B'
        elif operand == '(B)':                    #
                elem = '(B)'
                type_ = '(B)'
        elif '(' in operand:                       
            variable = operand[1:-1]
            if self.position_variables.get(variable, 'F') != 'F':                                  #
                elem = self.position_variables[variable] # Para quitar los paréntesis
                type_ = '(Dir)'
            else:                                  # MOV A,(Lit)
                elem = number_formatter(variable) 
                type_ = '(Dir)'
        else:                                      # MOV A,Lit  -- MOV A,Dir
            if self.position_variables.get(operand, 'F') != 'F': # Revisar si es un número o una variable mencionada. Muere si hay una variable llamada igual que un número 
                elem = self.position_variables[operand]
                type_ = 'Lit'
            else:
                elem = operand  
                type_ = 'Lit'
        return elem, type_  

    def instructionsToBytes(self):
        # print(*self.data_instructions+self.code_instructions, sep='\n')
        for line in self.data_instructions+self.code_instructions:
            print("-->", line)
            self.bytesArray += [getWordArray(**line)] # Descomprime y sobreescribe los kwargs los pares key-value del diccionario
        print("Terminamos de convertir a bytes las instrucciones presentes")

    def writeROM(self):
        rom_programmer = Basys3()
        print('Puertos: ', *rom_programmer.available_ports, sep='-->')

        # sys.exit()
        rom_programmer.begin(4) # Colocar acá la posición que le correspondería de USB
        print(self.bytesArray)
        for i, line in enumerate(self.bytesArray):
            rom_programmer.write(i, line)
        rom_programmer.end()
        print("Terminamos de sobreescribir la ROM. Espero que haya salido todo bien, AA,11")

    

"""
    def separate(self):
        instructions = []
        for line in self.code:
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
"""
        
if __name__ == '__main__':
    debug = True
    specific = True
    tests = ['./tests/Test 0 - Mínimo.txt',
             './tests/Test 1 - Ram y Status.txt',
             './tests/Test 2 - Indirecto y Stack.txt',
             './tests/Test 3 - Entrada y Salida.txt'] 

    # paths = tests if debug else [sys.argv[1]]
    if debug and specific: paths = [tests[int(sys.argv[1])]] # py assembler.py <número del test>
    elif debug: paths = tests                                # py assembler.py
    else: paths = [sys.argv[1]]                              # py assembler.py './tests/Te...'

    for path in paths:
        print(path, sys.argv[1])
        assembler = Assembler()
        assembler.execute_test(path)
        sys.exit()
        time.sleep(10)
