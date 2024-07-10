import Foundation

public enum InputType: Equatable {
    case rfid(id: Int, value: Int)
    case buttonPressed
    case unknown
    case exit
}

final public class InputController {
    private let pinController: PinController
    private let rfidController: RFIDControllerProtocol

    public init(pinController: PinController, rfidController: RFIDControllerProtocol) {
        self.pinController = pinController
        self.rfidController = rfidController
    }
    
    public func getInput() -> InputType {
#if os(Linux)
        while(true) {
            if let (uid, value) = rfidController.read() {
                return .rfid(id: uid, value: value)
            }
            else if pinController.isPressingButton() {
                return .buttonPressed
            }
            Thread.sleep(forTimeInterval: 0.1)
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
