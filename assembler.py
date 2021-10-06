from iic2343 import Basys3 # https://pypi.org/project/iic2343/ 
rom_programmer = Basys3()
for i in rom_programmer.available_ports:
    print(i.device)
if __name__ == '__main__':
    #Beginserialproggraming(stopstheCPUandenablesproggraming)
    rom_programmer.begin(4)
    # 12 bits address: 0, 36 bits word: 0x000301601
    # rom_programmer.write(0,bytearray([0x0, 0x00, 0x50, 0x00, 0x02]))
    # 12 bits address: 1, 36 bits word: 0x000301803
    # rom_programmer.write(1,bytearray([0x0, 0x00, 0x00, 0x18, 0x03]))
    # 12 bits address: 2, 36 bits word: 0x000201803
    # rom_programmer.write(2,bytearray([0x0, 0x00, 0x20, 0x18, 0x03]))
    # 12 bits address: 3, 36 bits word: 0x000002000
    # rom_programmer.write(3,bytearray([0x0, 0x00, 0x00, 0x20, 0x00]))
    # End serial proggraming (restarts CPU)
    rom_programmer.end()