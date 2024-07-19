import Foundation

class Playlist {
    let sounds: [Sound]
    private var current: Int

    init(sounds: [Sound]) {
        self.sounds = sounds
        self.current = 0
    }

    func reset() {
        current = 0
    }

    func getNextSound() -> Sound {
        let index = current % sounds.count
        current += 1
        return sounds[index]
    }
}
