import Foundation

final public class StoryController {
    private var lastSoundDate: Date?
    private var lastSound: Sound?
    private let soundPlayer: SoundPlayerProtocol
    private let idlePlaylist = Playlist(sounds: [.idle1, .idle2, .idle3, .idle4])

    private let introPlaylist = Playlist(sounds: [
        .intro1,
        .intro2,
        .intro3,
        .intro4,
        .intro5,
        .intro6
    ])

    private let level1Playlist = Playlist(sounds: [
        .level1Step1,
        .level1Step2,
        .level1Step3,
        .level1Step4,
        .level1Step5
    ])
    private let level1FinishedPlaylist = Playlist(sounds: [
        .level1Finish1,
        .level1Finish2,
        .level1Finish3,
        .level1Finish4,
        .level1Finish5
    ])

    private let level2Playlist = Playlist(sounds: [
        .level2Step1,
        .level2Step2,
        .level2Step3,
        .level2Step4,
        .level2Step5
    ])
    private let level2FinishedPlaylist = Playlist(sounds: [
        .level2Finish1,
        .level2Finish2,
        .level2Finish3,
        .level2Finish4,
        .level2Finish5
    ])

    private let level3Playlist = Playlist(sounds: [
        .level3Step1,
        .level3Step2,
        .level3Step3,
        .level3Step4,
        .level3Step5
    ])
    private let level3FinishedPlaylist = Playlist(sounds: [
        .level3Finish1,
        .level3Finish2,
        .level3Finish3,
        .level3Finish4,
        .level3Finish5
    ])

    private let level4Playlist = Playlist(sounds: [
        .level4Step1,
        .level4Step2,
        .level4Step3
    ])
    private let level4FinishedPlaylist = Playlist(sounds: [
        .level4Finish1,
        .level4Finish2,
        .level4Finish3
    ])

    private let level5Playlist = Playlist(sounds: [
        .level5Step1,
        .level5Step2,
        .level5Step3
    ])
    private let level5FinishedPlaylist = Playlist(sounds: [
        .level5Finish1,
        .level5Finish2,
        .level5Finish3
    ])

    private let completedPlaylist = Playlist(sounds: [
        .completed1,
        .completed2,
        .completed3
    ])

    public init(soundPlayer: SoundPlayerProtocol) {
        self.soundPlayer = soundPlayer
    }

    public func tellGameStart() {
        soundPlayer.play(sound: .gameStart)
    }

    public func tellIntroductionStory() {
        if let lastSoundDate = lastSoundDate, abs(lastSoundDate.timeIntervalSinceNow) > 120 {
            introPlaylist.reset()
        }
        let sound = introPlaylist.getNextSound()
        soundPlayer.play(sound: sound)
        lastSoundDate = Date()
    }

    public func tellIdleSound() {
        let sound = idlePlaylist.getNextSound()
        soundPlayer.play(sound: sound)
    }

    public func tellStoryFor(level: Level) {
        let playlist: Playlist
        switch level {
        case .level1: playlist = level1Playlist
        case .level2: playlist = level2Playlist
        case .level3: playlist = level3Playlist
        case .level4: playlist = level4Playlist
        case .level5: playlist = level5Playlist
        case .finishedLevel1: playlist = level1FinishedPlaylist
        case .finishedLevel2: playlist = level2FinishedPlaylist
        case .finishedLevel3: playlist = level3FinishedPlaylist
        case .finishedLevel4: playlist = level4FinishedPlaylist
        case .finishedLevel5: playlist = level5FinishedPlaylist
        case .completed: playlist = completedPlaylist
        }
        let sound = playlist.getNextSound()
        soundPlayer.play(sound: sound)
    }
}
