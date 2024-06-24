enum InputType: Equatable {
    case rfid(id: Int, value: Int)
    case buttonPressed
    case unknown
    case exit
}

class InputController {
    private let pinController = PinController()
    
    func getInput() -> InputType {
#if os(Linux)
        while(true) {
            // Check if RFID Tag is present and return
            // Check if button pressed and return
            if pinController.isPressingButton() {
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
