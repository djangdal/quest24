from mfrc522 import MFRC522
from machine import Pin
import utime

from os import uname
   
thisLevel = 10
thisLevelCompletion = thisLevel + 5
 
red = Pin(0, Pin.OUT)
green = Pin(1, Pin.OUT)
blue = Pin(2, Pin.OUT)

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

def greenLight(rdr):
    red.value(0)
    green.value(1)
    blue.value(0)
    
def redLight(rdr):
    red.value(1)
    green.value(0)
    blue.value(0)

def blueLight(rdr):
    red.value(0)
    green.value(0)
    blue.value(1)
    
def noLight(rdr):
    red.value(0)
    green.value(0)
    blue.value(0)

def do_read():
    rdr = MFRC522(sck=6,mosi=7,miso=4,rst=22,cs=5)
    print("")
    print("Place card before reader")
    print("")

    try:
        while True:
            utime.sleep_ms(500)
            (stat, tag_type) = rdr.request(rdr.REQIDL)

            # Check if we have a card nearby
            if stat != rdr.OK:
                continue
            
            print("")
            print("--------------------")
    
            # Get the card UID
            (stat, uid) = rdr.SelectTagSN()
            if stat != rdr.OK:
                print("UID read not OK")
                redLight(rdr)
                utime.sleep_ms(2000)
                noLight(rdr)
                continue
            
            # Read the data on the card
            addr = 17  # Address for the quest data
            read_status, read_data = rdr.read(addr)
            if len(read_data) < 1:
                print("Incorrect data on tag")
                redLight(rdr)
                utime.sleep_ms(2000)
                noLight(rdr)
                continue
            level = read_data[0]
            uidInt = uidToInt(uid)

            print("Card detected %s" % uidInt, " with level", level)
            
            # Check if it is the correct level for this station and write new level
            if level == thisLevel:
                data = [thisLevelCompletion] + [0] * 15 
                write_status = rdr.write(addr, data)
                print("Did write new level to card")
            
            # Read the data again
            read_status, read_data = rdr.read(addr)
            if len(read_data) < 1:
                print("Incorrect data on tag")
                redLight(rdr)
                utime.sleep_ms(2000)
                noLight(rdr)
                continue
            level = read_data[0]
            
            # Check that the tag has this stations completion value
            if level != thisLevelCompletion:
                # If level is outside quest range, show red
                if level < 0 or level > 100:
                    redLight(rdr)
                    print("Tag does not have correct level: ", level, " showing red light")
                else:
                    print("Tag has another stations level: ", level, " showing blue light")
                    blueLight(rdr)
                utime.sleep_ms(2000)
                noLight(rdr)
                continue

            # Tag has the correct level, show green light
            print("Tag %s" % uidInt, " has correct level: %s", level, " Showing green light")
            greenLight(rdr)
            utime.sleep_ms(2000)
            noLight(rdr)

    except KeyboardInterrupt:
        print("Bye")
            
do_read()

