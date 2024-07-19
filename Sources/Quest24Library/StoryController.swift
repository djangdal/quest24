import Foundation

final public class StoryController {
    private var lastSoundDate: Date?
    private var lastSound: Sound?
    private let soundPlayer: SoundPlayerProtocol

    private let infoPlaylist = Playlist(sounds: [
        .intro0,
        .intro1
    ])

    public init(soundPlayer: SoundPlayerProtocol) {
        self.soundPlayer = soundPlayer
    }

    public func tellIntroductionStory() {
        if let lastSoundDate = lastSoundDate, abs(lastSoundDate.timeIntervalSinceNow) > 4 {
            infoPlaylist.reset()
        }
        let sound = infoPlaylist.getNextSound()
        soundPlayer.play(sound: sound)
        lastSoundDate = Date()

//        guard let lastSound, let lastSoundDate = lastSoundDate, abs(lastSoundDate.timeIntervalSinceNow) < 10 else {
//            soundPlayer.play(sound: .noToken1)
//            self.lastSound = .noToken1
//            self.lastSoundDate = Date()
//            return
//        }
//        let newSound: Sound
//        switch lastSound {
//        case .noToken1: newSound = .noToken2
//        case .noToken2: newSound = .noToken3
//        case .noToken3: newSound = .noToken4
//        case .noToken4: newSound = .noToken5
//        case .noToken5: newSound = .noToken6
//        case .noToken6: newSound = .noToken7
//        case .noToken7: newSound = .noToken8
//        case .noToken8: newSound = .noToken9
//        case .noToken9: newSound = .noToken10
//        case .noToken10: newSound = .noToken11
//        case .noToken11: newSound = .noToken12
//        case .noToken12: newSound = .noToken12
//        default: return
//        }
//        self.lastSound = newSound
//        self.lastSoundDate = Date()
//        soundPlayer.play(sound: newSound)
    }

    public func tellStoryFor(level: Level) {
        switch level {
        case .level1:
            print("Welcome, you can now go and do level 1")
            soundPlayer.play(sound: .level1)
        case .finishedLevel1:
            print("Congratulations on finishing level 1, here are instruction for level 2")
            soundPlayer.play(sound: .level1Finished)
        case .level2:
            print("Here are the instructions for level 2 again")
            soundPlayer.play(sound: .level2)
        case .finishedLevel2:
            print("Congratulations on finishing level 2, here are instruction for level 3")
            soundPlayer.play(sound: .level2Finished)
        case .level3:
            print("Oh, you didnt understand it the first time. Here are the instructions again for level 3")
            soundPlayer.play(sound: .level3)
        case .finishedLevel3:
            print("Wow, you just finished level 3, halfway there!. Now you need to scan box number 4")
            soundPlayer.play(sound: .level3Finished)
        case .level4:
            print("Yeah thats my fault, you just need to scan box 4")
            soundPlayer.play(sound: .level4)
        case .finishedLevel4:
            print("Wow, level 4 is done! Here is level 5 and final instructions")
            soundPlayer.play(sound: .level4Finished)
        case .level5:
            print("Level 5 is super easy, just do it man!")
            soundPlayer.play(sound: .level5)
        case .finishedLevel5:
            print("You are the fucking GOAT! You just completed the entire quest. Come see me at midnight to get your reward!!")
            soundPlayer.play(sound: .level5Finished)
        case .completed:
            print("I'll say it again, good job! Come back at midnight for the reward!")
            soundPlayer.play(sound: .completed)
        }
    }
}
