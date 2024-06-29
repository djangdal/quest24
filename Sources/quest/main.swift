import Foundation
//import MFRC522

//let group = DispatchGroup()
//group.enter()
//group.notify(queue: DispatchQueue.main) {
//    exit(EXIT_SUCCESS)
//}
//
//signal(SIGINT) { signal in
//    print("Bye! \(signal)")
//    group.leave()
//}

// Create an object of the class MFRC522
//let rc522 = MFRC522()

// Welcome message
//print("Welcome to the MFRC522 data read example")
//print("Press Ctrl-C to stop.")
//
//while true {

    // Print UID
//    print("Card read UID: \(uid[0]), \(uid[1]), \(uid[2]), \(uid[3])")
//
//    // This is the default key for authentication
//    let key: [Byte] = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]
//
//    // Select the scanned tag
//    rc522.selectTag(serNum: uid)

    /*
    Read.py

    // Authenticate
    let statusAuth = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 8, sectorkey: key, serNum: uid)

    // Check if authenticated
    if statusAuth == rc522.MI_OK {
        rc522.read(blockAddr: 8)
        rc522.stopCrypto()
    } else {
        print("Authentication error")
    }
    */

    /*
    Dump.py
//    */
//    let status = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
//    // Check if authenticated
//    if status == rc522.MI_OK {
//        let byteArray = rc522.read(blockAddr: 1)
//        let intValue = byteArrayAsInt(bytes: byteArray)
//        print("The int is: \(intValue)")
//    }

//    rc522.stopCrypto()


    /*
    Write.py

    // Authenticate
    let statusAuth = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 8, sectorkey: key, serNum: uid)
    print("\n")    

    // Check if authenticated
    if statusAuth != rc522.MI_OK {
        print("Authentication error")
        continue
    }

    print("Sector 8 looked like this:")
    rc522.read(blockAddr: 8)
    print("\n")

    print("Sector 8 will now be filled with 0xFF:")
    // Write the data
    rc522.write(blockAddr: 8, writeData: Array(repeating: (0xFF as Byte), count: 16))
    print("\n")

    print("It now looks like this:")
    // Check to see if it was written
    rc522.read(blockAddr: 8)
    print("\n")

    print("Now we fill it with 0x00:")
    rc522.write(blockAddr: 8, writeData: Array(repeating: (0x00 as Byte), count: 16))
    print("\n")

    print("It is now empty:")
    // Check to see if it was written
    rc522.read(blockAddr: 8)
    print("\n")

    // Stop    
    rc522.stopCrypto()
    */

    /*
    // Write NDEF
    guard rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 4, sectorkey: key, serNum: uid) == rc522.MI_OK else {
        print("Error reading block 4")
        break
    }

    print("\nBlock 4 looked like this:")
    rc522.read(blockAddr: 4)
    print("\n")

    print("Writing NDEF message to block 4")
    rc522.write(blockAddr: 4, writeData: [0x00, 0x00, 0x03, 0x11, 0xD1, 0x01, 0x0D, 0x55, 0x01, 0x61, 0x64, 0x61, 0x66, 0x72, 0x75, 0x69])
    print("\n")

    print("It now looks like this:")
    rc522.read(blockAddr: 4)
    print("\n")

    guard rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 5, sectorkey: key, serNum: uid) == rc522.MI_OK else {
        print("Error reading block 5")
        break
    }

    print("\nBlock 5 looked like this:")
    rc522.read(blockAddr: 5)
    print("\n")

    print("Writing NDEF message to block 5")
    rc522.write(blockAddr: 5, writeData: [0x74, 0x2E, 0x63, 0x6F, 0x6D, 0xFE, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
    print("\n")

    print("It now looks like this:")
    rc522.read(blockAddr: 5)
    print("\n")

    guard rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 6, sectorkey: key, serNum: uid) == rc522.MI_OK else {
        print("Error reading block 6")
        break
    }

    print("\nBlock 6 looked like this:")
    rc522.read(blockAddr: 6)
    print("\n")

    print("Writing NDEF message to block 6")
    rc522.write(blockAddr: 6, writeData: Array(repeating: (0x00 as Byte), count: 16))
    print("\n")

    print("It now looks like this:")
    rc522.read(blockAddr: 6)
    print("\n")

    rc522.stopCrypto()
    */
//}
//
//dispatchMain()




























 let storyController = StoryController()
 let inputController = InputController()
 let storageController = StorageController()
 let rfidController = RFIDController()

// let mfrc522 = MFRC522()
// mfrc522.start()
// print("RFID Reader Initialized")
// func readUIDAndBlockData() {
//     mfrc522.start()

//     let (status1, _) = mfrc522.request(reqMode: mfrc522.PICC_REQIDL)
//     if status1 != mfrc522.MI_OK {
//         print("No tag detected")
//         return
//     }

//     let(status, uid) = mfrc522.anticoll()
//     if status != mfrc522.MI_OK {
//         print("Failed to read UID")
//         return
//     }

//     let serNum = uid
//     print("UID: \(uid.map { String(format: "%02hhx", $0) }.joined(separator: ", "))")

//     let key: [Byte] = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF] // Default key

//     let authStatus = mfrc522.auth(authMode: mfrc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
//     if authStatus != mfrc522.MI_OK {
//         print("Authentication error")
//         return
//     }

//     mfrc522.read(blockAddr: 1)
//     mfrc522.stopCrypto()
// }
// while true {
//     readUIDAndBlockData()
    // let (statusSearch, tagType) = mfrc522.request(reqMode: mfrc522.PICC_REQIDL)

        // If a card is found
        // if statusSearch == mfrc522.MI_OK {
        //     print("Card detected")
        //     let (status, uidLittleEndian, uidBigEndian) = mfrc522.SelectTagSN()
        //     if status == mfrc522.MI_OK {
        //         if let uidLE = uidLittleEndian {
        //             print("UID as Int (Little Endian): \(uidLE)")
        //         }
        //         if let uidBE = uidBigEndian {
        //             print("UID as Int (Big Endian): \(uidBE)")
        //         }
        //     } else {
        //         print("Failed to read UID")
        //     }
//     usleep(500000)  // Sleep for 500 ms
// }
 print("----------Hi and welcome---------------")
 print("Enter \"exit\" to exit")
 print("Simulate button with \"b\"")
 print("Enter RFID tag and value in format \"xxx,yy\"")
 print("Levels are:")
 print("level1 = 10")
 print("finishedLevel1 = 15")
 print("level2 = 20")
 print("finishedLevel2 = 25")
 print("level3 = 30")
 print("finishedLevel3 = 35")
 print("level4 = 40")
 print("finishedLevel4 = 45")
 print("level5 = 50")
 print("finishedLevel5 = 55")

 var shouldExit = false
 while(!shouldExit) {
     switch inputController.getInput() {
     case .rfid(let id, let value):
         guard let level = Level(rawValue: value) else {
             storageController.storeInvalidInput(id: id, value: value)
             print("Invalid input of level, id: \(id), value: \(value)")
             continue
         }
         if level.isLevelFinished && level != .finishedLevel5 {
             let nextLevel = level.nextLevel
//             rfidController.writeNew(level: nextLevel)
             storageController.storeLevelUpgrade(id: id, for: nextLevel)
         }
         storyController.tellStoryFor(level: level)
     case .buttonPressed:
         print("Button pressed")
         storageController.storeButtonPressed()
         storyController.tellIntroductionStory()
     case .exit:
         shouldExit = true
     case .unknown:
         print("Unknown input")
         continue
     }
 }
