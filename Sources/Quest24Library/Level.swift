public enum Level: Int {
    case level1 = 10
    case finishedLevel1 = 15
    case level2 = 20
    case finishedLevel2 = 25
    case level3 = 30
    case finishedLevel3 = 35
    case level4 = 40
    case finishedLevel4 = 45
    case level5 = 50
    case finishedLevel5 = 55
}

public extension Level {
    var isLevelFinished: Bool {
        switch self {
        case .level1, .level2, .level3, .level4, .level5: return false
        case .finishedLevel1, .finishedLevel2, .finishedLevel3, .finishedLevel4, .finishedLevel5: return true
        }
    }
    
    var nextLevel: Level {
        switch self {
        case .finishedLevel1: return .level2
        case .finishedLevel2: return .level3
        case .finishedLevel3: return .level4
        case .finishedLevel4: return .level5
        default: return self
        }
    }
}
