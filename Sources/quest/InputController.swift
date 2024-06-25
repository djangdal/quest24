import Foundation

enum InputType: Equatable {
    case rfid(id: Int, value: Int)
    case buttonPressed
    case unknown
    case exit
}

class InputController {
    private let pinController = PinController()
    private let mfrc522 = MFRC522()
    func getInput() -> InputType {
#if os(Linux)
        while(true) {
            // Check if RFID Tag is present and return
            // Check if button pressed and return

            let (statusSearch, tagType) = mfrc522.request(reqMode: mfrc522.PICC_REQIDL)

            // If a card is found
            if statusSearch == mfrc522.MI_OK {
                print("Card detected")
                let (status, uidLittleEndian, uidBigEndian) = mfrc522.SelectTagSN()
                if status == mfrc522.MI_OK {
                    if let uidLE = uidLittleEndian {
                        print("UID as Int (Little Endian): \(uidLE)")
                    }
                    if let uidBE = uidBigEndian {
                        print("UID as Int (Big Endian): \(uidBE)")
                    }
                } else {
                    print("Failed to read UID")
                }
            } else if pinController.isPressingButton() {
                return .buttonPressed
            }

            Thread.sleep(forTimeInterval: 0.1)
        }
#endif
        guard let line = readLine() else { return .unknown }
        if line == "b" {
            return .buttonPressed
        }
        if line == "exit" {
            return .exit
        }
        let inputs = line.components(separatedBy: ",")
        if inputs.count == 2, let id = Int(inputs[0]), let value = Int(inputs[1]) {
            return .rfid(id: id, value: value)
        } else {
            return .unknown
        }
    }
}
