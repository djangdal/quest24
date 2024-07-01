import Foundation

final public class StoryController {
    private var lastSoundDate: Date?
    private var lastSound: Sound?
    private let soundPlayer: SoundPlayerProtocol

    public init(soundPlayer: SoundPlayerProtocol) {
        self.soundPlayer = soundPlayer
    }

    public func tellIntroductionStory() {
        guard let lastSound, let lastSoundDate = lastSoundDate, abs(lastSoundDate.timeIntervalSinceNow) < 10 else {
            soundPlayer.play(sound: .noToken1)
            self.lastSound = .noToken1
            self.lastSoundDate = Date()
            return
        }
        let newSound: Sound
        switch lastSound {
        case .noToken1: newSound = .noToken2
        case .noToken2: newSound = .noToken3
        case .noToken3: newSound = .noToken4
        case .noToken4: newSound = .noToken5
        case .noToken5: newSound = .noToken6
        case .noToken6: newSound = .noToken7
        case .noToken7: newSound = .noToken8
        case .noToken8: newSound = .noToken9
        case .noToken9: newSound = .noToken10
        case .noToken10: newSound = .noToken11
        case .noToken11: newSound = .noToken12
        case .noToken12: newSound = .noToken12
        }
        self.lastSound = newSound
        self.lastSoundDate = Date()
        soundPlayer.play(sound: newSound)
    }

    public func tellStoryFor(level: Level) {
        switch level {
        case .level1:
            print("Instructions on how to do level 1")
        case .finishedLevel1:
            print("Congratulations on finishing level 1, here are instruction for level 2")
        case .level2:
            print("Repeat instructions for level 2")
        case .finishedLevel2:
            print("Congratulations on finishing level 2, here are instruction for level 3")
        case .level3:
            print("Repeat instructions for level 3")
        case .finishedLevel3:
            print("Congratulations on finishing level 3, here are instruction for level 4")
        case .level4:
            print("Repeat instructions for level 4")
        case .finishedLevel4:
            print("Congratulations on finishing level 4, here are instruction for level 5")
        case .level5:
            print("Repeat instructions for level 5")
        case .finishedLevel5:
            print("Congratulations on finishing level 5, you have completed the quest")
        }
    }
}
