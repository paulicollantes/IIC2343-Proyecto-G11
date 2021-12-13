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
""" Retorna un string con la versión hexadecimal del valor y deja listo el string de bits 
    más significativos (lado izquierdo del opcode) """
def formatter(literal=''):
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
        return  hex(literal)[2:]+'000'
        
def getWordArray(instruction = 'JMP', type1='', type2='', elemento1='', elemento2=''):
        global DICC
        print("DICT FORMAT", instruction, type1, type2, elemento1, elemento2    )
        types = ['Lit', 'Ins', 'Dir']
        operands = f'{type1},{type2}'
        opcode = DICC[instruction][operands]
        if type1 in types:
            mostSignificatives = formatter(elemento1)
        elif type2 in types:
            mostSignificatives = formatter(elemento2)
        else:
            mostSignificatives = formatter('')
        wordArray = []
    
        if instruction == 'RET':
            pre_opcode = DICC['incSP'][operands]
            pre_mostSignificatives = formatter('')
            wordArray.append(int(pre_mostSignificatives + hex(pre_opcode)[2:],16).to_bytes(5,'big'))
        elif instruction == 'POP':
            pre_opcode = DICC['incSP'][',']
            pre_mostSignificatives= formatter('')
            wordArray.append(int(pre_mostSignificatives + hex(pre_opcode)[2:],16).to_bytes(5,'big'))
        wordArray.append(int(mostSignificatives + hex(opcode)[2:],16).to_bytes(5,'big'))
        return wordArray


if __name__ == '__main__':
    print(bytearray([0x1e, 0x1e, 0x02, 0 << 8]))
    print(hex(2 << 4))  
    a = bytearray([0x00, 0x10])[1]
    b = bytearray(b'0000000000010000')
    print(a, b, a==b)
    print("-"*160)

    print(int(formatter('010011111111b')+hex(0xFF)[2:],16).to_bytes(5,'big'))
    print(bytearray([0x4f, (0x2<<4) + 0xf]))

    print('ff', (25).to_bytes(5, 'big'))
    print('gg', (500).to_bytes(5, 'big'))

    print(getWordArray(instruction='XOR', type1="A", elemento1=0x1F3F, type2="Lit", elemento2=0x2A3A))

    #Beginserialproggraming(stopstheCPUandenablesproggraming)
    #rom_programmer.begin(4)
    # 12 bits address: 0, 36 bits word: 0x000301601
    # rom_programmer.write(0,bytearray([0x0, 0x00, 0x50, 0x00, 0x02]))
    # 12 bits address: 1, 36 bits word: 0x000301803
    # rom_programmer.write(1,bytearray([0x0, 0x00, 0x00, 0x18, 0x03]))
    # 12 bits address: 2, 36 bits word: 0x000201803
    # rom_programmer.write(2,bytearray([0x0, 0x00, 0x20, 0x18, 0x03]))
    # 12 bits address: 3, 36 bits word: 0x000002000
    # rom_programmer.write(3,bytearray([0x0, 0x00, 0x00, 0x20, 0x00]))
    # End serial proggraming (restarts CPU)
    #rom_programmer.end() 