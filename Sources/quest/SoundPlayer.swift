import PythonKit

enum Sound: String {
    case noToken1 = "no-token-1"
    case noToken2 = "no-token-2"
    case noToken3 = "no-token-3"
    case noToken4 = "no-token-4"
    case noToken5 = "no-token-5"
    case noToken6 = "no-token-6"
    case noToken7 = "no-token-7"
    case noToken8 = "no-token-8"
    case noToken9 = "no-token-9"
    case noToken10 = "no-token-10"
    case noToken11 = "no-token-11"
    case noToken12 = "no-token-12"
}

final class SoundPlayer {
    private let pythonPlayer: PythonObject
    
    init() {
        let sys = Python.import("sys")
        sys.path.append("Sources/quest/")
        pythonPlayer = Python.import("sound")
    }
    
    public func play(sound: Sound) {
        pythonPlayer.play(sound.rawValue)
    }
}
