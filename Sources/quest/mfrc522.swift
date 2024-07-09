// #if os(Linux)
// import Foundation
// import Glibc
// import SwiftyGPIO

// public typealias Byte = UInt8

// public class MFRC522 {
//     public let NRSTPD: GPIOName            = .P22

//     public let MAX_LEN: Int                = 16

//     public let PCD_IDLE: Byte              = 0x00
//     public let PCD_AUTHENT: Byte           = 0x0E
//     public let PCD_RECEIVE: Byte           = 0x08
//     public let PCD_TRANSMIT: Byte          = 0x04
//     public let PCD_TRANSCEIVE: Byte        = 0x0C
//     public let PCD_RESETPHASE: Byte        = 0x0F
//     public let PCD_CALCCRC: Byte           = 0x03

//     public let PICC_REQIDL: Byte           = 0x26
//     public let PICC_REQALL: Byte           = 0x52
//     public let PICC_ANTICOLL: Byte         = 0x93
//     public let PICC_ANTICOLL1: Byte        = 0x93
//     public let PICC_ANTICOLL2: Byte        = 0x95
//     public let PICC_ANTICOLL3: Byte        = 0x97
//     public let PICC_SElECTTAG: Byte        = 0x93
//     public let PICC_AUTHENT1A: Byte        = 0x60
//     public let PICC_AUTHENT1B: Byte        = 0x61
//     public let PICC_READ: Byte             = 0x30
//     public let PICC_WRITE: Byte            = 0xA0
//     public let PICC_DECREMENT: Byte        = 0xC0
//     public let PICC_INCREMENT: Byte        = 0xC1
//     public let PICC_RESTORE: Byte          = 0xC2
//     public let PICC_TRANSFER: Byte         = 0xB0
//     public let PICC_HALT: Byte             = 0x50

//     public let MI_OK: Byte                 = 0
//     public let MI_NOTAGERR: Byte           = 1
//     public let MI_ERR: Byte                = 2

//     public let Reserved00: Byte            = 0x00
//     public let CommandReg: Byte            = 0x01
//     public let CommIEnReg: Byte            = 0x02
//     public let DivlEnReg: Byte             = 0x03
//     public let CommIrqReg: Byte            = 0x04
//     public let DivIrqReg: Byte             = 0x05
//     public let ErrorReg: Byte              = 0x06
//     public let Status1Reg: Byte            = 0x07
//     public let Status2Reg: Byte            = 0x08
//     public let FIFODataReg: Byte           = 0x09
//     public let FIFOLevelReg: Byte          = 0x0A
//     public let WaterLevelReg: Byte         = 0x0B
//     public let ControlReg: Byte            = 0x0C
//     public let BitFramingReg: Byte         = 0x0D
//     public let CollReg: Byte               = 0x0E
//     public let Reserved01: Byte            = 0x0F

//     public let Reserved10: Byte            = 0x10
//     public let ModeReg: Byte               = 0x11
//     public let TxModeReg: Byte             = 0x12
//     public let RxModeReg: Byte             = 0x13
//     public let TxControlReg: Byte          = 0x14
//     public let TxAutoReg: Byte             = 0x15
//     public let TxSelReg: Byte              = 0x16
//     public let RxSelReg: Byte              = 0x17
//     public let RxThresholdReg: Byte        = 0x18
//     public let DemodReg: Byte              = 0x19
//     public let Reserved11: Byte            = 0x1A
//     public let Reserved12: Byte            = 0x1B
//     public let MifareReg: Byte             = 0x1C
//     public let Reserved13: Byte            = 0x1D
//     public let Reserved14: Byte            = 0x1E
//     public let SerialSpeedReg: Byte        = 0x1F

//     public let Reserved20: Byte            = 0x20
//     public let CRCResultRegM: Byte         = 0x21
//     public let CRCResultRegL: Byte         = 0x22
//     public let Reserved21: Byte            = 0x23
//     public let ModWidthReg: Byte           = 0x24
//     public let Reserved22: Byte            = 0x25
//     public let RFCfgReg: Byte              = 0x26
//     public let GsNReg: Byte                = 0x27
//     public let CWGsPReg: Byte              = 0x28
//     public let ModGsPReg: Byte             = 0x29
//     public let TModeReg: Byte              = 0x2A
//     public let TPrescalerReg: Byte         = 0x2B
//     public let TReloadRegH: Byte           = 0x2C
//     public let TReloadRegL: Byte           = 0x2D
//     public let TCounterValueRegH: Byte     = 0x2E
//     public let TCounterValueRegL: Byte     = 0x2F

//     public let Reserved30: Byte            = 0x30
//     public let TestSel1Reg: Byte           = 0x31
//     public let TestSel2Reg: Byte           = 0x32
//     public let TestPinEnReg: Byte          = 0x33
//     public let TestPinValueReg: Byte       = 0x34
//     public let TestBusReg: Byte            = 0x35
//     public let AutoTestReg: Byte           = 0x36
//     public let VersionReg: Byte            = 0x37
//     public let AnalogTestReg: Byte         = 0x38
//     public let TestDAC1Reg: Byte           = 0x39
//     public let TestDAC2Reg: Byte           = 0x3A
//     public let TestADCReg: Byte            = 0x3B
//     public let Reserved31: Byte            = 0x3C
//     public let Reserved32: Byte            = 0x3D
//     public let Reserved33: Byte            = 0x3E
//     public let Reserved34: Byte            = 0x3F

//     var serNum: [Byte]              = []
//     public let board: SupportedBoard       = .RaspberryPi4
//     public let speed: UInt32               = 1000000
//     public let spi: SysFSSPI
//     public let gpios: [GPIOName: GPIO]

//     public init() {
//         spi = (SwiftyGPIO.hardwareSPIs(for: board)?.first as? SysFSSPI)!
//         gpios = SwiftyGPIO.GPIOs(for: board)
//         spi.setMaxSpeedHz(speed)

//         //        GPIO.setmode(GPIO.BOARD)
//         let nrstpd = gpios[NRSTPD]!
//         nrstpd.direction = .OUT
//         nrstpd.value = 1
//         start()
//     }

//     public func start() {
//         reset()

//         write(addr: TModeReg, val: 0x8D)
//         write(addr: TPrescalerReg, val: 0x3E)
//         write(addr: TReloadRegL, val: 30)
//         write(addr: TReloadRegH, val: 0)
//         write(addr: TxAutoReg, val: 0x40)
//         write(addr: ModeReg, val: 0x3D)
//         antennaOn()
//     }

//     public func reset() {
//         write(addr: CommandReg, val: PCD_RESETPHASE)
//     }

//     public func write(addr: Byte, val: Byte) {
//         spi.sendData([
//             (addr << 1) & 0x7E,
//             val
//         ])
//     }

//     public func write(blockAddr: Byte, writeData: [Byte]) {
//         var buff: [Byte] = [
//             PICC_WRITE,
//             blockAddr
//         ]
//         let crc = calulateCRC(pIndata: buff)
//         buff.append(crc[0])
//         buff.append(crc[1])

//         var (status, backData, backLen) = toCard(command: PCD_TRANSCEIVE, sendData: buff)
//         if status != MI_OK || backLen != 4 || (backData[0] & 0x0F) != 0x0A {
//             status = MI_ERR
//         }

//         print("\(backLen) backdata & 0x0F == 0x0A \(backData[0] & 0x0F)")
//         if status == MI_OK {
//             var buf: [Byte] = []
//             for i in 0 ..< 16 {
//                 buf.append(writeData[i])
//             }
//             let crc = calulateCRC(pIndata: buf)
//             buf.append(crc[0])
//             buf.append(crc[1])
//             let (status, backData, backLen) = toCard(command: PCD_TRANSCEIVE, sendData: buf)
//             if status != MI_OK || backLen != 4 || (backData[0] & 0x0F) != 0x0A {
//                 print("Error while writing")
//             }
//             if status == MI_OK {
//                 print("Data written")
//             }
//         }
//     }

//     public func read(addr: Byte) -> Byte {
//         let val = spi.sendDataAndRead([
//             ((addr << 1) & 0x7E) | 0x80,
//             0
//         ])
//         return val[1]
//     }

//     public func read(blockAddr: Byte, shouldPrint: Bool = false) -> [Byte] {
//         var recvData: [Byte] = [
//             PICC_READ,
//             blockAddr
//         ]
//         let pOut = calulateCRC(pIndata: recvData)
//         recvData.append(pOut[0])
//         recvData.append(pOut[1])
//         let (status, backData, _) = toCard(command: PCD_TRANSCEIVE, sendData: recvData)
//         if shouldPrint, status != MI_OK {
//             print("Error while reading!")
//         }
//         if shouldPrint, backData.count == 16 {
//             print("Sector \(blockAddr) -> \(backData.map { String(format: "%02hhx", $0) }.joined(separator: ", "))")
//         }
//         return backData
//     }

//     public func setBitMask(reg: Byte, mask: Byte) {
//         let tmp = read(addr: reg)
//         write(addr: reg, val: tmp | mask)
//     }

//     public func clearBitMask(reg: Byte, mask: Byte) {
//         let tmp = read(addr: reg)
//         write(addr: reg, val: tmp & (~mask))
//     }

//     public func antennaOn() {
//         let temp = read(addr: TxControlReg)
//         if ~(temp & 0x03) != 0 {
//             setBitMask(reg: TxControlReg, mask: 0x03)
//         }
//     }

//     public func antennaOff() {
//         clearBitMask(reg: TxControlReg, mask: 0x03)
//     }

//     public func toCard(command: Byte, sendData: [Byte]) -> (status: Byte, backData: [Byte], backLen: Int) {
//         var backData: [Byte] = []
//         var backLen = 0
//         var status = MI_ERR
//         var irqEn: Byte = 0x00
//         var waitIRq: Byte = 0x00

//         if command == PCD_AUTHENT {
//             irqEn = 0x12
//             waitIRq = 0x10
//         }

//         if command == PCD_TRANSCEIVE {
//             irqEn = 0x77
//             waitIRq = 0x30
//         }

//         write(addr: CommIEnReg, val: irqEn | 0x80)
//         clearBitMask(reg: CommIrqReg, mask: 0x80)
//         setBitMask(reg: FIFOLevelReg, mask: 0x80)

//         write(addr: CommandReg, val: PCD_IDLE)

//         sendData.forEach { byteToSend in
//             write(addr: FIFODataReg, val: byteToSend)
//         }

//         write(addr: CommandReg, val: command)

//         if command == self.PCD_TRANSCEIVE {
//             setBitMask(reg: BitFramingReg, mask: 0x80)
//         }

//         var i = 2000
//         var n: Byte = 0
//         repeat {
//             n = read(addr: CommIrqReg)
//             i = i - 1
//         } while !(i == 0 || (n & 0x01) != 0 || (n & waitIRq) != 0)

//         clearBitMask(reg: BitFramingReg, mask: 0x80)

//         if i != 0 {
//             if (read(addr: ErrorReg) & 0x1B) == 0x00 {
//                 status = MI_OK

//                 if (n & irqEn & 0x01) != 0 {
//                     status = MI_NOTAGERR
//                 }

//                 if command == PCD_TRANSCEIVE {
//                     var size = Int(read(addr: FIFOLevelReg))
//                     let lastBits = Int(read(addr: ControlReg) & 0x07)

//                     print("The first size is \(size)")
//                     if lastBits != 0 {
//                         backLen = (size - 1) * 8 + lastBits
//                     } else {
//                         backLen = size * 8
//                     }
//                     print("The zise after if is \(size)")

//                     if size == 0 { size = 1 }
//                     if size > MAX_LEN { size = MAX_LEN }
//                     for k in 0 ..< size {
//                     print("The k is \(k)")
//                         backData.append(read(addr: FIFODataReg))
//                     }
//                 }
//             } else {
//                 status = MI_ERR
//             }
//         }

//         return (status: status, backData: backData, backLen: backLen)
//     }

//     // public func request(reqMode: Byte) -> (status: Byte, backBits: Int) {
//     //     write(addr: BitFramingReg, val: 0x07)

//     //     let (status, _, backBits) = toCard(command: PCD_TRANSCEIVE, sendData: [reqMode])

//     //     if status != MI_OK || backBits != 0x10 {
//     //         return (status: MI_ERR, backBits: backBits)
//     //     }

//     //     return (status, backBits)
//     // }
    
//     func request(mode: UInt8) -> (Byte, Int) {
//         write(addr: BitFramingReg, val: 0x07)
//         let (stat, _, bits) = toCard(command: PCD_TRANSCEIVE, sendData: [mode])

//         if (stat != MI_OK) || (bits != 0x10) {
//             return (MI_ERR, bits)
//         }

//         return (stat, bits)
//     }

//     public func getUIDInLittleEndian() -> UInt32? {
//         let (status, uidBytes) = anticoll(anticolN: PICC_ANTICOLL1)
        
//         guard status == MI_OK, uidBytes.count >= 4 else {
//             return nil
//         }

//         let uid = UInt32(uidBytes[0]) |
//                   (UInt32(uidBytes[1]) << 8) |
//                   (UInt32(uidBytes[2]) << 16) |
//                   (UInt32(uidBytes[3]) << 24)

//         return uid
//     }

//     public func anticoll(anticolN: Byte) -> (status: Byte, backData: [Byte]) {
//         write(addr: BitFramingReg, val: 0x00)

//         let serNum = [anticolN, 0x20]
//         var (status, backData, backLen) = toCard(command: PCD_TRANSCEIVE, sendData: serNum)
//         print("Backdata count \(backData.count) len \(backLen)")
//         if status == MI_OK {
//             if backData.count == 8 {
//                 if backData.dropLast().reduce(0, ^) != backData.last {
//                     status = MI_ERR
//                 }
//             } else {
//                 status = MI_ERR
//             }
//         }

//         return (status: status, backData: backData)
//     }

//     public func calulateCRC(pIndata: [Byte]) -> [Byte] {
//         clearBitMask(reg: DivIrqReg, mask: 0x04)
//         setBitMask(reg: FIFOLevelReg, mask: 0x80)
//         pIndata.forEach {
//             write(addr: FIFODataReg, val: $0)
//         }
//         write(addr: CommandReg, val: PCD_CALCCRC)
//         var i = 0xFF
//         var n: Byte
//         repeat {
//             n = read(addr: DivIrqReg)
//             i = i - 1
//         } while ((i != 0) && (n & 0x04) == 0)

//         return [
//             read(addr: CRCResultRegL),
//             read(addr: CRCResultRegM)
//         ]
//     }

//     public func selectTag(serNum: [Byte]) -> Byte {
//         var buf: [Byte] = [PICC_SElECTTAG, 0x70]
//         for i in 0 ..< 5 {
//             buf.append(serNum[i])
//         }
//         let pOut = calulateCRC(pIndata: buf)
//         buf.append(pOut[0])
//         buf.append(pOut[1])
//         let (status, backData, backLen) = toCard(command: PCD_TRANSCEIVE, sendData: buf)

//         if status == MI_OK && backLen == 0x18 {
//             print("Size: \(backData[0])")
//             return backData[0]
//         }
//         else {
//             return 0
//         }
//     }
    
//     func selectTagSN() -> (Byte, [UInt8]) {
//         var valid_uid: [UInt8] = []
//         var (status, uid) = anticoll(anticolN: PICC_ANTICOLL1)

//         if status != MI_OK {
//             return (MI_ERR, [])
//         }

//         if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL1) {
//             return (MI_ERR, [])
//         }

//         if uid[0] == 0x88 {
//             valid_uid.append(contentsOf: uid[1...3])
//             (status, uid) = anticoll(anticolN: PICC_ANTICOLL2)

//             if status != MI_OK {
//                 return (MI_ERR, [])
//             }

//             if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL2) {
//                 return (MI_ERR, [])
//             }

//             if uid[0] == 0x88 {
//                 valid_uid.append(contentsOf: uid[1...3])
//                 (status, uid) = anticoll(anticolN: PICC_ANTICOLL3)

//                 if status != MI_OK {
//                     return (MI_ERR, [])
//                 }

//                 if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL3) {
//                     return (MI_ERR, [])
//                 }
//             }
//         }
//         valid_uid.append(contentsOf: uid[0...4])
//         return (MI_OK, Array(valid_uid.prefix(valid_uid.count - 1)))
//     }

//     func selectCard(serNum: [UInt8], anticolN: UInt8) -> Bool {
//         var buf: [UInt8] = [anticolN, 0x70]
//         buf.append(contentsOf: serNum)
//         let crcResult = calulateCRC(pIndata: buf)
//         buf.append(contentsOf: crcResult)
//         let (status, _, backLen) = toCard(command: 0x0C, sendData: buf)

//         return (status == MI_OK) && (backLen == 0x18)
//     }

//     public func auth(authMode: Byte, blockAddr: Byte, sectorkey: [Byte], serNum: [Byte]) -> Byte {
//         var buff: [Byte] = []

//         // First byte should be the authMode (A or B)
//         buff.append(authMode)

//         // Second byte is the trailerBlock (usually 7)
//         buff.append(blockAddr)

//         // Now we need to append the authKey which usually is 6 bytes of 0xFF
//         buff.append(contentsOf: sectorkey)

//         // Next we append the first 4 bytes of the UID
//         for i in 0 ..< 4 {
//             buff.append(serNum[i])
//         }

//         // Now we start the authentication itself
//         let (status, _, _) = toCard(command: PCD_AUTHENT, sendData: buff)

//         // Check if an error occurred
//         if status != MI_OK {
//             print("AUTH ERROR!!")
//         }

//         if (read(addr: Status2Reg) & 0x08) == 0 {
//             print("AUTH ERROR(status2reg & 0x08) != 0")
//         }

//         return status
//     }

//     public func stopCrypto() {
//         clearBitMask(reg: Status2Reg, mask: 0x08)
//     }

//     public func dumpClassic1K(key: [Byte], uid: [Byte]) {
//         for i: Byte in 0 ..< 64 {
//             let status = auth(authMode: PICC_AUTHENT1A, blockAddr: i, sectorkey: key, serNum: uid)
//             // Check if authenticated
//             if status == MI_OK {
//                 read(blockAddr: i)
//             } else {
//                 print("Authentication error")
//             }
//         }
//     }
// }
// #endif
