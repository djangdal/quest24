// import Foundation
// import CoreFoundation
// import SwiftyGPIO

// class MFRC522 {
//     enum Status: Int {
//         case ok = 0
//         case noTagErr = 1
//         case err = 2
//     }

//     enum NTag: Int {
//         case none = 0
//         case nTag213 = 213
//         case nTag215 = 215
//         case nTag216 = 216
//     }

//     let REQIDL: UInt8 = 0x26
//     let REQALL: UInt8 = 0x52
//     let AUTHENT1A: UInt8 = 0x60
//     let AUTHENT1B: UInt8 = 0x61

//     let PICC_ANTICOLL1: UInt8 = 0x93
//     let PICC_ANTICOLL2: UInt8 = 0x95
//     let PICC_ANTICOLL3: UInt8 = 0x97

//     var sck: GPIO
//     var mosi: GPIO
//     var miso: GPIO
//     var rst: GPIO
//     var cs: GPIO
//     var spi: SysFSSPI

//     var NTAG: NTag = .none
//     var NTAG_MaxPage: Int = 0

//     init(sck: Int, mosi: Int, miso: Int, rst: Int, cs: Int, baudrate: Int = 1000000, spiId: Int = 0) {
//         self.sck = GPIO(sck, direction: .out)
//         self.mosi = GPIO(mosi, direction: .out)
//         self.miso = GPIO(miso, direction: .`in`)
//         self.rst = GPIO(rst, direction: .out)
//         self.cs = GPIO(cs, direction: .out)

//         self.rst.write(value: 0)
//         self.cs.write(value: 1)

//         self.spi = SPI(spiId: spiId, baudrate: baudrate, sck: self.sck, mosi: self.mosi, miso: self.miso)

//         self.rst.write(value: 1)
//         self.initRFID()
//     }

//     func writeRegister(_ reg: UInt8, value: UInt8) {
//         cs.write(value: 0)
//         spi.write([UInt8(0xff & ((reg << 1) & 0x7e))])
//         spi.write([value])
//         cs.write(value: 1)
//     }

//     func readRegister(_ reg: UInt8) -> UInt8 {
//         cs.write(value: 0)
//         spi.write([UInt8(0xff & (((reg << 1) & 0x7e) | 0x80))])
//         let val = spi.read(length: 1)
//         cs.write(value: 1)
//         return val[0]
//     }

//     func setFlags(_ reg: UInt8, mask: UInt8) {
//         writeRegister(reg, value: readRegister(reg) | mask)
//     }

//     func clearFlags(_ reg: UInt8, mask: UInt8) {
//         writeRegister(reg, value: readRegister(reg) & (~mask))
//     }

//     func toCard(cmd: UInt8, send: [UInt8]) -> (Status, [UInt8], Int) {
//         var recv: [UInt8] = []
//         var bits = 0
//         var irq_en: UInt8 = 0
//         var wait_irq: UInt8 = 0
//         var n = 0
//         var stat: Status = .err

//         if cmd == 0x0E {
//             irq_en = 0x12
//             wait_irq = 0x10
//         } else if cmd == 0x0C {
//             irq_en = 0x77
//             wait_irq = 0x30
//         }

//         writeRegister(0x02, value: irq_en | 0x80)
//         clearFlags(0x04, mask: 0x80)
//         setFlags(0x0A, mask: 0x80)
//         writeRegister(0x01, value: 0x00)

//         for c in send {
//             writeRegister(0x09, value: c)
//         }
//         writeRegister(0x01, value: cmd)

//         if cmd == 0x0C {
//             setFlags(0x0D, mask: 0x80)
//         }

//         var i = 2000
//         while true {
//             n = Int(readRegister(0x04))
//             i -= 1
//             if ~((i != 0) && ~(n & 0x01) && ~(n & wait_irq)) {
//                 break
//             }
//         }

//         clearFlags(0x0D, mask: 0x80)

//         if i {
//             if (readRegister(0x06) & 0x1B) == 0x00 {
//                 stat = .ok

//                 if (n & Int(irq_en) & 0x01) != 0 {
//                     stat = .noTagErr
//                 } else if cmd == 0x0C {
//                     n = Int(readRegister(0x0A))
//                     let lbits = Int(readRegister(0x0C) & 0x07)
//                     if lbits != 0 {
//                         bits = (n - 1) * 8 + lbits
//                     } else {
//                         bits = n * 8
//                     }

//                     if n == 0 {
//                         n = 1
//                     } else if n > 16 {
//                         n = 16
//                     }

//                     for _ in 0..<n {
//                         recv.append(readRegister(0x09))
//                     }
//                 }
//             } else {
//                 stat = .err
//             }
//         }

//         return (stat, recv, bits)
//     }

//     func crc(data: [UInt8]) -> [UInt8] {
//         clearFlags(0x05, mask: 0x04)
//         setFlags(0x0A, mask: 0x80)

//         for c in data {
//             writeRegister(0x09, value: c)
//         }

//         writeRegister(0x01, value: 0x03)

//         var i = 0xFF
//         while true {
//             let n = readRegister(0x05)
//             i -= 1
//             if !((i != 0) && !(n & 0x04 != 0)) {
//                 break
//             }
//         }

//         return [readRegister(0x22), readRegister(0x21)]
//     }

//     func initRFID() {
//         reset()
//         writeRegister(0x2A, value: 0x8D)
//         writeRegister(0x2B, value: 0x3E)
//         writeRegister(0x2D, value: 30)
//         writeRegister(0x2C, value: 0)
//         writeRegister(0x15, value: 0x40)
//         writeRegister(0x11, value: 0x3D)
//         antennaOn()
//     }

//     func reset() {
//         writeRegister(0x01, value: 0x0F)
//     }

//     func antennaOn(on: Bool = true) {
//         if on && !(readRegister(0x14) & 0x03 != 0) {
//             setFlags(0x14, mask: 0x03)
//         } else {
//             clearFlags(0x14, mask: 0x03)
//         }
//     }

//     func request(mode: UInt8) -> (Status, Int) {
//         writeRegister(0x0D, value: 0x07)
//         let (stat, _, bits) = toCard(cmd: 0x0C, send: [mode])

//         if (stat != .ok) || (bits != 0x10) {
//             return (.err, bits)
//         }

//         return (stat, bits)
//     }

//     func anticoll(anticolN: UInt8) -> (Status, [UInt8]) {
//         var ser_chk: UInt8 = 0
//         var ser: [UInt8] = [anticolN, 0x20]

//         writeRegister(0x0D, value: 0x00)
//         let (stat, recv, _) = toCard(cmd: 0x0C, send: ser)

//         if stat == .ok {
//             if recv.count == 5 {
//                 for i in 0..<4 {
//                     ser_chk ^= recv[i]
//                 }
//                 if ser_chk != recv[4] {
//                     return (.err, recv)
//                 }
//             } else {
//                 return (.err, recv)
//             }
//         }

//         return (stat, recv)
//     }

//     func selectCard(serNum: [UInt8], anticolN: UInt8) -> Bool {
//         var buf: [UInt8] = [anticolN, 0x70]
//         buf.append(contentsOf: serNum)
//         let crcResult = crc(data: buf)
//         buf.append(contentsOf: crcResult)
//         let (status, _, backLen) = toCard(cmd: 0x0C, send: buf)

//         return (status == .ok) && (backLen == 0x18)
//     }

//     func selectTag(uid: [UInt8]) -> (Status, [UInt8]) {
//         var byte5: UInt8 = 0
//         for i in uid {
//             byte5 ^= i
//         }
//         let puid = uid + [byte5]

//         if !selectCard(serNum: puid, anticolN: PICC_ANTICOLL1) {
//             return (.err, [])
//         }

//         return (.ok, uid)
//     }

//     func selectTagSN() -> (Status, [UInt8]) {
//         var valid_uid: [UInt8] = []
//         var (status, uid) = anticoll(anticolN: PICC_ANTICOLL1)

//         if status != .ok {
//             return (.err, [])
//         }

//         if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL1) {
//             return (.err, [])
//         }

//         if uid[0] == 0x88 {
//             valid_uid.append(contentsOf: uid[1...3])
//             (status, uid) = anticoll(anticolN: PICC_ANTICOLL2)

//             if status != .ok {
//                 return (.err, [])
//             }

//             if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL2) {
//                 return (.err, [])
//             }

//             if uid[0] == 0x88 {
//                 valid_uid.append(contentsOf: uid[1...3])
//                 (status, uid) = anticoll(anticolN: PICC_ANTICOLL3)

//                 if status != .ok {
//                     return (.err, [])
//                 }

//                 if !selectCard(serNum: uid, anticolN: PICC_ANTICOLL3) {
//                     return (.err, [])
//                 }
//             }
//         }
//         valid_uid.append(contentsOf: uid[0...4])
//         return (.ok, Array(valid_uid.prefix(valid_uid.count - 1)))
//     }

//     func authenticate(mode: UInt8, addr: UInt8, sect: [UInt8], ser: [UInt8]) -> Status {
//         return toCard(cmd: 0x0E, send: [mode, addr] + sect + ser).0
//     }

//     func authenticateKeys(uid: [UInt8], addr: UInt8, keyA: [UInt8]? = nil, keyB: [UInt8]? = nil) -> Status {
//         var status: Status = .err
//         if let keyA = keyA {
//             status = authenticate(mode: AUTHENT1A, addr: addr, sect: keyA, ser: uid)
//         } else if let keyB = keyB {
//             status = authenticate(mode: AUTHENT1B, addr: addr, sect: keyB, ser: uid)
//         }
//         return status
//     }

//     func stopCrypto1() {
//         clearFlags(0x08, mask: 0x08)
//     }

//     func read(addr: UInt8) -> (Status, [UInt8]) {
//         var data: [UInt8] = [0x30, addr]
//         data.append(contentsOf: crc(data: data))
//         let (stat, recv, _) = toCard(cmd: 0x0C, send: data)
//         return (stat, recv)
//     }

//     func write(addr: UInt8, data: [UInt8]) -> Status {
//         var buf: [UInt8] = [0xA0, addr]
//         buf.append(contentsOf: crc(data: buf))
//         var (stat, recv, bits) = toCard(cmd: 0x0C, send: buf)

//         if (stat != .ok) || (bits != 4) || ((recv[0] & 0x0F) != 0x0A) {
//             stat = .err
//         } else {
//             buf = Array(data.prefix(16))
//             buf.append(contentsOf: crc(data: buf))
//             (stat, recv, bits) = toCard(cmd: 0x0C, send: buf)
//             if (stat != .ok) || (bits != 4) || ((recv[0] & 0x0F) != 0x0A) {
//                 stat = .err
//             }
//         }
//         return stat
//     }

//     func writeSectorBlock(uid: [UInt8], sector: Int, block: Int, data: [UInt8], keyA: [UInt8]? = nil, keyB: [UInt8]? = nil) -> Status {
//         let absoluteBlock = sector * 4 + (block % 4)
//         if absoluteBlock > 63 || data.count != 16 {
//             return .err
//         }
//         if authenticateKeys(uid: uid, addr: UInt8(absoluteBlock), keyA: keyA, keyB: keyB) != .err {
//             return write(addr: UInt8(absoluteBlock), data: data)
//         }
//         return .err
//     }

//     func readSectorBlock(uid: [UInt8], sector: Int, block: Int, keyA: [UInt8]? = nil, keyB: [UInt8]? = nil) -> (Status, [UInt8]?) {
//         let absoluteBlock = sector * 4 + (block % 4)
//         if absoluteBlock > 63 {
//             return (.err, nil)
//         }
//         if authenticateKeys(uid: uid, addr: UInt8(absoluteBlock), keyA: keyA, keyB: keyB) != .err {
//             return read(addr: UInt8(absoluteBlock))
//         }
//         return (.err, nil)
//     }

//     func dumpClassic1K(uid: [UInt8], start: Int = 0, end: Int = 64, keyA: [UInt8]? = nil, keyB: [UInt8]? = nil) -> Status {
//         for absoluteBlock in start..<end {
//             let status = authenticateKeys(uid: uid, addr: UInt8(absoluteBlock), keyA: keyA, keyB: keyB)
//             print("\(absoluteBlock) S\(absoluteBlock / 4) B\(absoluteBlock % 4): ", terminator: "")
//             if status == .ok {
//                 let (status, block) = read(addr: UInt8(absoluteBlock))
//                 if status == .err {
//                     break
//                 } else {
//                     for value in block {
//                         print(String(format: "%02X ", value), terminator: "")
//                     }
//                     print("  ", terminator: "")
//                     for value in block {
//                         if (value > 0x20) && (value < 0x7f) {
//                             print(Character(UnicodeScalar(value)), terminator: "")
//                         } else {
//                             print(".", terminator: "")
//                         }
//                     }
//                     print("")
//                 }
//             } else {
//                 break
//             }
//         }
//         if status == .err {
//             print("Authentication error")
//             return .err
//         }
//         return .ok
//     }

//     func dumpNtag(start: Int = 0, end: Int = 135) -> Status {
//         for absoluteBlock in stride(from: start, to: end, by: 4) {
//             let maxIndex = 4 * 135
//             let status: Status = .ok
//             print("Page \(absoluteBlock): ", terminator: "")
//             if status == .ok {
//                 let (status, block) = read(addr: UInt8(absoluteBlock))
//                 if status == .err {
//                     break
//                 } else {
//                     var index = absoluteBlock * 4
//                     for i in 0..<block.count {
//                         if index < maxIndex {
//                             print(String(format: "%02X ", block[i]), terminator: "")
//                         } else {
//                             print("   ", terminator: "")
//                         }
//                         if (i % 4) == 3 {
//                             print(" ", terminator: "")
//                         }
//                         index += 1
//                     }
//                     print("  ", terminator: "")
//                     index = absoluteBlock * 4
//                     for value in block {
//                         if index < maxIndex {
//                             if (value > 0x20) && (value < 0x7f) {
//                                 print(Character(UnicodeScalar(value)), terminator: "")
//                             } else {
//                                 print(".", terminator: "")
//                             }
//                         }
//                         index += 1
//                     }
//                     print("")
//                 }
//             } else {
//                 break
//             }
//         }
//         if status == .err {
//             print("Authentication error")
//             return .err
//         }
//         return .ok
//     }

//     func writeNtagPage(page: Int, data: [UInt8]) -> Status {
//         if page > NTAG_MaxPage || page < 4 || data.count != 4 {
//             return .err
//         }
//         return write(addr: UInt8(page), data: data + [UInt8](repeating: 0, count: 12))
//     }

//     func getNtagVersion() -> (Status, [UInt8]) {
//         var buf: [UInt8] = [0x60]
//         buf.append(contentsOf: crc(data: buf))
//         let (stat, recv, _) = toCard(cmd: 0x0C, send: buf)
//         return (stat, recv)
//     }

//     func isNtag() -> Bool {
//         NTAG = .none
//         NTAG_MaxPage = 0
//         let (stat, rcv) = getNtagVersion()
//         if stat == .ok {
//             if rcv.count < 8 {
//                 return false
//             }
//             if rcv[0] != 0 || rcv[1] != 4 || rcv[2] != 4 || rcv[3] != 2 || rcv[7] != 3 {
//                 return false
//             }
//             if rcv[6] == 0xf {
//                 NTAG = .nTag213
//                 NTAG_MaxPage = 44
//                 return true
//             } else if rcv[6] == 0x11 {
//                 NTAG = .nTag215
//                 NTAG_MaxPage = 134
//                 return true
//             } else if rcv[6] == 0x13 {
//                 NTAG = .nTag216
//                 NTAG_MaxPage = 230
//                 return true
//             }
//         }
//         return false
//     }
// }
