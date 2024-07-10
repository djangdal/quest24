import PythonKit
import Quest24Library

final public class RFIDController: RFIDControllerProtocol {
#if os(Linux)
    private let pythonPlayer: PythonObject
#endif

    public init() {
#if os(Linux)
        let sys = Python.import("sys")
        sys.path.append("Sources/Quest24")
        pythonPlayer = Python.import("rfid")
#endif
    }

    public func read() -> (Int, Int)? {
#if os(Linux)
        let input = pythonPlayer.read()
        print("saker \(input)")
        guard let uid = input.0 as? Int, let value = input.1 as? Int else { return nil }
        return (uid, value)
#endif
        return nil
    }

    public func write(level: Level) {
#if os(Linux)
        pythonPlayer.write(level.rawValue)
        print("did saker")
#endif
    }
}

//final public class RFIDController: RFIDControllerProtocol {
//#if os(Linux)
//
//    // private let mfrc522 = MFRC522()
//
//#endif
//    public init() {
//    }
//
//    public func writeNew(level: Level) {
//#if os(Linux)
//        // Write new level to rfid
//#endif
//    }
//
//    public func readCard() -> UInt32? {
//
//#if os(Linux)
//        // let (statusSearch, tagType) = rc522.request(reqMode: rc522.PICC_REQIDL)
//
//        // If a card is found
//        // guard statusSearch == rc522.MI_OK else { return nil }
//
//        // Get the UID of the card
//        // let (statusUUID, uid) = mfrc522.anticoll()
//
//        // If we have the UID, continue
//        // guard statusUUID == mfrc522.MI_OK else { return nil }
//        // return uid
//        return nil
//#else
//        return nil
//#endif
//    }
//
//    public func readValue() -> UInt32? {
//// #if os(Linux)
//        // let status = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
//        // // Check if authenticated
//        // guard status == rc522.MI_OK else { return nil }
//        // let byteArray = rc522.read(blockAddr: 1)
//        // let intValue = byteArrayAsInt(bytes: byteArray)
//        // return intValue
//// #endif
//        return nil
//    }
//
//#if os(Linux)
//    private func byteArrayAsInt(bytes: [Byte]) -> Int {
//        let intValue = UInt32(bytes[0]) |
//                (UInt32(bytes[1]) << 8) |
//                (UInt32(bytes[2]) << 16) |
//                (UInt32(bytes[3]) << 24)
//
//        return Int(intValue)
//    }
//
//#endif
//}
