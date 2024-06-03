//
//  StoryController.swift
//  
//
//  Created by David Jangdal on 2024-06-03.
//

import Foundation

enum Stage {
    case none
    case noToken(sound: Sound)
}

class StoryController {
    var stage: Stage = .none
    var lastSoundDate: Date?

    init() {
        
    }
    
    func soundFor(rfid: String?) -> Sound {
        guard let rfid else { return noTokenSound() }
        return soundFor(rfid: rfid)
    }
    
    private func soundFor(rfid: String) -> Sound {
        return .noToken1
    }
    
    private func noTokenSound() -> Sound {
        guard let lastSoundDate = lastSoundDate, abs(lastSoundDate.timeIntervalSinceNow) < 10 else {
            stage = .noToken(sound: .noToken1)
            return .noToken1
        }
        guard case .noToken(let sound) = stage else {
            stage = .noToken(sound: .noToken1)
            return .noToken1
        }
        let newSound: Sound
        switch sound {
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
        stage = .noToken(sound: newSound)
        return newSound
    }
    
    func finishedPlaying() {
        lastSoundDate = Date()
    }
}
