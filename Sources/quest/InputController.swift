import Foundation
import MFRC522

enum InputType: Equatable {
    case rfid(id: Int, value: Int)
    case buttonPressed
    case unknown
    case exit
}

class InputController {
    private let pinController = PinController()
    private let rfidController = RFIDController()
    private let key: [Byte] = [0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF]

    func getInput() -> InputType {
#if os(Linux)
        while(true) {
            if let uid = rfidController.readUID() {
                let intID = rfidController.byteArrayAsInt(bytes: uid)
                print("The uid \(uid), the id: \(intID)")
                // if let value = rfidController.readValue(uid: uid, key: key) {
                //     print("Value: \(value)")
                //     return .rfid(id: intID, value: value)
                // }
            } else if pinController.isPressingButton() {
                return .buttonPressed
            }
            Thread.sleep(forTimeInterval: 0.5)
        }
#else
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
#endif
    }
}
