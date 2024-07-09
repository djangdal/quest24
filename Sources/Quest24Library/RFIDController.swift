import MFRC522

public protocol RFIDControllerProtocol {
    func writeNew(level: Level)
    func readCard() -> UInt32?
    func readValue() -> UInt32?
}

final public class RFIDController: RFIDControllerProtocol {
#if os(Linux)

    private let mfrc522 = MFRC522()
<<<<<<< HEAD:Sources/quest/RFIDController.swift

    func writeNew(level: Level) {
        // Write new level to rfid
    }

    func readUID() -> [Byte]? {
        // let (statusSearch, _) = mfrc522.request(mode: mfrc522.PICC_REQIDL)

        // If a card is found
        // guard statusSearch == mfrc522.MI_OK else { return nil }
=======
#endif
    public init() {
    }

    public func writeNew(level: Level) {
#if os(Linux)
        // Write new level to rfid
#endif
    }

    public func readCard() -> UInt32? {

#if os(Linux)
        let (statusSearch, tagType) = rc522.request(reqMode: rc522.PICC_REQIDL)

        // If a card is found
        guard statusSearch == rc522.MI_OK else { return nil }
>>>>>>> 8d30c43213ed9e920a73390dc0e8044cf4d1c2de:Sources/Quest24Library/RFIDController.swift

        // Get the UID of the card
        // let (statusUUID, uid) = mfrc522.anticoll()

        // If we have the UID, continue
<<<<<<< HEAD:Sources/quest/RFIDController.swift
        // guard statusUUID == mfrc522.MI_OK else { return nil }
        // return uid
        return nil
    }

    func readValue(uid: [Byte], key: [Byte]) -> Int? {
        // _ = mfrc522.selectTag(serNum: uid)

        // let status = mfrc522.auth(authMode: mfrc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
        // // Check if authenticated
        // guard status == mfrc522.MI_OK else { return nil }
        // let byteArray = mfrc522.read(blockAddr: 1)
        // let intValue = byteArrayAsInt(bytes: byteArray)
        // mfrc522.stopCrypto()
        // return intValue
        return nil
    }

    func byteArrayAsInt(bytes: [Byte]) -> Int {
=======
        guard statusUUID == rc522.MI_OK else { return nil }

        let intValue = byteArrayAsInt(bytes: uid)
        return intValue
#endif
        return nil
    }

    public func readValue() -> UInt32? {
#if os(Linux)
        let status = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
        // Check if authenticated
        guard status == rc522.MI_OK else { return nil }
        let byteArray = rc522.read(blockAddr: 1)
        let intValue = byteArrayAsInt(bytes: byteArray)
        return intValue
#endif
        return nil
    }

#if os(Linux)
    private func byteArrayAsInt(bytes: [Byte]) -> UInt32 {
>>>>>>> 8d30c43213ed9e920a73390dc0e8044cf4d1c2de:Sources/Quest24Library/RFIDController.swift
        let intValue = UInt32(bytes[0]) |
                (UInt32(bytes[1]) << 8) |
                (UInt32(bytes[2]) << 16) |
                (UInt32(bytes[3]) << 24)

        return Int(intValue)
    }

#endif
}
