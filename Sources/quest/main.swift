import Foundation
// import MFRC522

//  let storyController = StoryController()
//  let inputController = InputController()
//  let storageController = StorageController()
//  let rfidController = RFIDController()

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

func uidToString(uid: [UInt8]) -> String {
    return uid.reversed().map { String(format: "%02X", $0) }.joined()
}

func bytesToHex(byteList: [UInt8]) -> String {
    return byteList.map { String(format: "%02X", $0) }.joined()
}

func uidToInt(uid: [UInt8]) -> Int {
    return uid.reduce(0) { ($0 << 8) | Int($1) }
}

func doRead() {
    let rdr = MFRC522()
    print("\nPlace card before reader to read from address 0x08\n")

    do {
        while true {
            let (stat, tagType) = rdr.request(mode: rdr.PICC_REQIDL)

            if stat == rdr.MI_OK {
                print("\n--------------------")
                
                let (stat, uid) = rdr.selectTagSN()
                
                // if stat == rdr.MI_OK {
                    print("Card detected \(uid)")
            //         // Uncomment the below lines if needed
            //         // print("Card detected \(uidToString(uid: uid))")
            //         // print("Card detected \(uidToInt(uid: uid))")
            //         print("Card detected \(bytesToHex(byteList: uid))")
            //         let addr: UInt8 = 8  // Example block address

            //         let (readStatus, readData) = rdr.read(addr: addr)
            //         print("Read Status:", readStatus)
            //         print("Data:", readData)
                    
            //         let data: [UInt8] = [42] + [UInt8](repeating: 0, count: 15)  // Number 42 followed by 15 zeros
            //         let writeStatus = rdr.write(addr: addr, data: data)
            //         print("Write Status:", writeStatus)
                // } else {
                //     print("Authentication error")
                // }
            }
            sleep(1)
        }
    } catch {
        print("Bye")
    }
}

// Example usage
doRead()




//  var shouldExit = false
//  while(!shouldExit) {
//     switch inputController.getInput() {
//     case .rfid(let id, let value):
//         guard let level = Level(rawValue: value) else {
//             storageController.storeInvalidInput(id: id, value: value)
//             print("Invalid input of level, id: \(id), value: \(value)")
//             continue
//         }
//         if level.isLevelFinished && level != .finishedLevel5 {
//             let nextLevel = level.nextLevel
// //             rfidController.writeNew(level: nextLevel)
//             storageController.storeLevelUpgrade(id: id, for: nextLevel)
//         }
//         storyController.tellStoryFor(level: level)
//     case .buttonPressed:
//         print("Button pressed")
//         storageController.storeButtonPressed()
//         storyController.tellIntroductionStory()
//     case .exit:
//         shouldExit = true
//     case .unknown:
//         print("Unknown input")
//         continue
//     }
//  }







// let group = DispatchGroup()
// group.enter()
// group.notify(queue: DispatchQueue.main) {
//    exit(EXIT_SUCCESS)
// }

// signal(SIGINT) { signal in
//    print("Bye! \(signal)")
//    group.leave()
// }

// // Create an object of the class MFRC522
// let rc522 = MFRC522()

// // Welcome message
// print("Welcome to the MFRC522 data read example")
// print("Press Ctrl-C to stop.")

// while true {

//     let (statusSearch, tagType) = rc522.request(reqMode: rc522.PICC_REQIDL)

//     // If a card is found
//     if statusSearch == rc522.MI_OK {
//         print("Card detected")
//     } else {
//         sleep(1)
//         continue
//     }

//     // Get the UID of the card
//     let (statusUUID, uid) = rc522.anticoll()

//     // If we have the UID, continue
//     guard statusUUID == rc522.MI_OK else { break }

//     // Print UID
//     print("Card read UID: \(uid[0]), \(uid[1]), \(uid[2]), \(uid[3])")

//     // This is the default key for authentication
//     let key: [Byte] = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]

//     // Select the scanned tag
//     // rc522.selectTag(serNum: uid)
//     let statusAuth = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)

//     // Check if authenticated
//     if statusAuth == rc522.MI_OK {
//         rc522.read(blockAddr: 1)
//         rc522.stopCrypto()
//     } else {
//         print("Authentication error")
//     }

// }

// dispatchMain()