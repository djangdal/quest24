import MFRC522

final class RFIDController {
#if os(Linux)

    private let mfrc522 = MFRC522()

    func writeNew(level: Level) {
        // Write new level to rfid
    }

    func readUID() -> [Byte]? {
        let (statusSearch, _) = mfrc522.request(mode: mfrc522.PICC_REQIDL)

        // If a card is found
        guard statusSearch == mfrc522.MI_OK else { return nil }

        // Get the UID of the card
        // let (statusUUID, uid) = mfrc522.anticoll()

        // If we have the UID, continue
        // guard statusUUID == mfrc522.MI_OK else { return nil }
        // return uid
        return nil
    }

    func readValue(uid: [Byte], key: [Byte]) -> Int? {
        _ = mfrc522.selectTag(serNum: uid)

        let status = mfrc522.auth(authMode: mfrc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
        // Check if authenticated
        guard status == mfrc522.MI_OK else { return nil }
        let byteArray = mfrc522.read(blockAddr: 1)
        let intValue = byteArrayAsInt(bytes: byteArray)
        mfrc522.stopCrypto()
        return intValue
    }

    func byteArrayAsInt(bytes: [Byte]) -> Int {
        let intValue = UInt32(bytes[0]) |
                (UInt32(bytes[1]) << 8) |
                (UInt32(bytes[2]) << 16) |
                (UInt32(bytes[3]) << 24)

        return Int(intValue)
    }

#endif
}
