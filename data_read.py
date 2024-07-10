from mfrc522 import MFRC522
#import utime

from os import uname


def uidToString(uid):
    mystring = ""
    for i in uid:
        mystring = "%02X" % i + mystring
    return mystring

def bytesToHex(byte_list):
    return ''.join(f'{b:02X}' for b in byte_list)

def uidToInt(uid):
    result = 0
    for b in uid:
        result = (result << 8) | b
    return result
    
def do_read():
    rdr = MFRC522(sck=6,mosi=7,miso=4,rst=22,cs=5)
    print("")
    print("Place card before reader to read from address 0x08")
    print("")

    try:
        while True:

            (stat, tag_type) = rdr.request(rdr.REQIDL)

            if stat == rdr.OK:
                print("")
                print("--------------------")
        
                (stat, uid) = rdr.SelectTagSN()
            
                if stat == rdr.OK:
                    print("Card detected %s" % uid)
#                     print("Card detected %s" % uidToString(uid))
#                     print("Card detected %s" % uidToInt(uid))
                    #print("Card detected %s" % bytesToHex(uid))
                    addr = 8  # Example block address
                    print("----Will now read the data----")
                    read_status, read_data = rdr.read(addr)
                    #print("Read Status:", read_status)
                    print("Data:", read_data)
                    
                    data = [42] + [0] * 15  # Number 42 followed by 15 zeros
                    write_status = rdr.write(addr, data)
                    #print("write Status:", write_status)
                    
                    
                else:
                    print("Authentication error")

    except KeyboardInterrupt:
        print("Bye")

print("")
print("Please place card on any reader")
print("")

# try:
#     while True:
# 
#         (readerID, uid) = readers.checkAnyReader()
#         if readerID != -1:
#             print(" RFID card:", uidToString(uid), " from ",readerID)
            
            
do_read()
#         status, uid = reader.SelectTagSN()
#         if status == reader.OK:
#             print("UID:", uid)
#             
#             # Authenticate with keyA
#             keyA = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
#             addr = 8  # Example block address
#             
# #             auth_status = reader.authKeys(uid, addr, keyA)
#             auth_status = reader.auth(reader.AUTHENT1A, addr, keyA, uid)
#             print("Authentication Status:", auth_status)
#             
#             if auth_status == reader.OK:
#                 # Read data from block
#                 read_status, data = reader.read(addr)
#                 print("Read Status:", read_status)
#                 print("Data:", data)
#             else:
#                 print("Authentication failed")
#         else:
#             print("Failed to select tag")

#         utime.sleep_ms(50)                

# except KeyboardInterrupt:
#     pass





# from mfrc522 import MFRC522
# import utime
# import random
#  
# reader = MFRC522(spi_id=0,sck=6,miso=4,mosi=7,cs=5,rst=22)
#  
# print("Bring TAG closer...")
# print("")
# 
# def write_random_value(reader, uid):
#     # Generate a random number between 0 and 100
#     random_value = random.randint(0, 100)
#     
#     # Convert the random number to a single byte
#     random_value_bytes = [random_value]  # list with a single byte
#     
#     # Pad the rest of the block with zeros
#     data_to_write = random_value_bytes + [0] * 15
#     
#     # Authenticate to a block (example uses block 1)
#     block = 1
#     status = reader.auth(reader.AUTHENT1A, block, [0xff, 0xff, 0xff, 0xff, 0xff, 0xff], uid)
#     if status == reader.OK:
#         # Write the random value to block 1
#         status = reader.write(block, data_to_write)
#         if status == reader.OK:
#             return random_value
#         else:
#             print("Failed to write random value")
#             return None
#     else:
#         print("Failed to authenticate block")
#         return None
#     
# def readValue(reader, uid):
#     block = 1
#     status = reader.auth(reader.AUTHENT1A, block, [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF], uid)
#     if status == reader.OK:
#         print("Status ok, reading it")
#         (stat, data) = reader.read(block)  # Read from block 1
#         if stat == reader.OK:
#             return data[0]
#     else:
#         print("Could not read value, auth error")
#         
# while True:
#     reader.init()
#     (stat, tag_type) = reader.request(reader.REQIDL)
#     if stat == reader.OK:
#         print("")
#         print("--------------------")
#         status, uid = reader.SelectTagSN()
#         if status == reader.OK:
#             print("UID:", uid)
#             
#             # Authenticate with keyA
#             keyA = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
#             addr = 8  # Example block address
#             
# #             auth_status = reader.authKeys(uid, addr, keyA)
#             auth_status = reader.auth(reader.AUTHENT1A, addr, keyA, uid)
#             print("Authentication Status:", auth_status)
#             
#             if auth_status == reader.OK:
#                 # Read data from block
#                 read_status, data = reader.read(addr)
#                 print("Read Status:", read_status)
#                 print("Data:", data)
#             else:
#                 print("Authentication failed")
#         else:
#             print("Failed to select tag")
#             
#             
# #         status, uid = reader.SelectTagSN()
# #         print("UID:", uid)
# #         keyA = [0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5]
# #         keyA = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
# #         keyB = None
# #         addr = 8  # Change to the appropriate block address
# #         status = reader.authKeys(uid, addr, keyA, keyB)
# #         print("Authentication Status:", status)
# #        (stat, uid) = reader.SelectTagSN()        
# #         if stat == reader.OK:
# #             card = int.from_bytes(bytes(uid), "little", False)
# #             currentValue = readValue(reader, uid)
# #                     
# #             #random_value = write_random_value(reader, uid)
# #             #newValue = readValue(reader, uid)
# #             print("CARD ID: " + str(card) + ", current value: " + str(currentValue))# + " New value: " + str(newValue))            
# #         else:
# #             print("Failed to select tag")
# 
#     utime.sleep(1)
