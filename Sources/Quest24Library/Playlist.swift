import Foundation

public class Playlist {
    let sounds: [Sound]
    private var current: Int

    public init(sounds: [Sound]) {
        self.sounds = sounds
        self.current = 0
    }

    public func reset() {
        current = 0
    }

    public func getNextSound() -> Sound {
        let index = current % sounds.count
        current += 1
        return sounds[index]
    }
}
