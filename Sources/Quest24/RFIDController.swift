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
        // print("saker \(input)")
        let tuple = input.tuple2
        guard tuple.0 != Python.None, let uid = [UInt8](tuple.0) else { return nil }
        let uidInt = convertToInt(array: uid)
        // print("Saker uidInt \(uidInt), uid: \(uid)")
        guard tuple.1 != Python.None, let value = Int(tuple.1) else { return nil }
        // print("Saker value \(value)")
        // return nil
        return (uidInt, value)
#else
        return nil
#endif
    }

    public func write(level: Level) {
#if os(Linux)
        pythonPlayer.write(level.rawValue)
        print("did saker")
#endif
    }

    private func convertToInt(array: [UInt8]) -> Int {
        var result: Int = 0
        for byte in array {
            result = (result << 8) | Int(byte)
        }
    return result
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
