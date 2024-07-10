import Foundation

public protocol RFIDControllerProtocol {
    func read() -> (Int, Int)?
    func write(level: Level)
}
