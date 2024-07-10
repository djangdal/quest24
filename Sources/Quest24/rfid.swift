import PythonKit
import Quest24Library

final public class RFID {
    private let pythonPlayer: PythonObject
    // private let reader: PythonObject

    public init() {
        let sys = Python.import("sys")
        sys.path.append("Sources/Quest24")
        pythonPlayer = Python.import("rfid")
    }
    
    public func read() {
        let v = pythonPlayer.read()
        print("saker \(v)")
    }
    
    public func write(value: Int) {
        pythonPlayer.write(value)
        print("did saker")
    }
    // public func read(sector: Int) -> [Int] {
    //     pythonPlayer.MFRC522_Request(0x26)
    // }
}
