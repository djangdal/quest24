import MFRC522

final class RFIDController {
#if os(Linux)

    private let mfrc522 = MFRC522()
    func writeNew(level: Level) {
        // Write new level to rfid
    }

    func readCard() -> UInt32? {
        let (statusSearch, tagType) = rc522.request(reqMode: rc522.PICC_REQIDL)

        // If a card is found
        guard statusSearch == rc522.MI_OK else { return nil }
        print("Card detected")

        // Get the UID of the card
        let (statusUUID, uid) = rc522.anticoll()

        // If we have the UID, continue
        guard statusUUID == rc522.MI_OK else { return nil }

        let intValue = byteArrayAsInt(bytes: uid)
        return intValue
    }

    func readValue() -> UInt32? {
        let status = rc522.auth(authMode: rc522.PICC_AUTHENT1A, blockAddr: 1, sectorkey: key, serNum: uid)
        // Check if authenticated
        guard status == rc522.MI_OK else { return nil }
        let byteArray = rc522.read(blockAddr: 1)
        let intValue = byteArrayAsInt(bytes: byteArray)
        return intValue
    }

    func byteArrayAsInt(bytes: [Byte]) -> UInt32 {
        let intValue = UInt32(bytes[0]) |
                (UInt32(bytes[1]) << 8) |
                (UInt32(bytes[2]) << 16) |
                (UInt32(bytes[3]) << 24)

        return intValue
    }
#endif
}
