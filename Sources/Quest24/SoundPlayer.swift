import PythonKit
import Quest24Library

final public class SoundPlayer: SoundPlayerProtocol {
    private let pythonPlayer: PythonObject
    
    public init() {
        let sys = Python.import("sys")
        sys.path.append("Sources/Quest24")
        pythonPlayer = Python.import("sound")
    }
    
    public func play(sound: Sound) {
        pythonPlayer.play(sound.rawValue)
    }
}
