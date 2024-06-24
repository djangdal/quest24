import Foundation

let storyController = StoryController()
let inputController = InputController()
let storageController = StorageController()
let rfidController = RFIDController()

print("----------Hi and welcome---------------")
print("Enter \"exit\" to exit")
print("Simulate button with \"b\"")
print("Enter RFID tag and value in format \"xxx,yy\"")
print("Levels are:")
print("level1 = 10")
print("finishedLevel1 = 15")
print("level2 = 20")
print("finishedLevel2 = 25")
print("level3 = 30")
print("finishedLevel3 = 35")
print("level4 = 40")
print("finishedLevel4 = 45")
print("level5 = 50")
print("finishedLevel5 = 55")

var shouldExit = false
while(!shouldExit) {
    switch inputController.getInput() {
    case .rfid(let id, let value):
        guard let level = Level(rawValue: value) else {
            storageController.storeInvalidInput(id: id, value: value)
            print("Invalid input of level, id: \(id), value: \(value)")
            continue
        }
        if level.isLevelFinished { // Check if max level reached
            let nextLevel = level.nextLevel
            rfidController.writeNew(level: nextLevel)
            storageController.storeLevelUpgrade(id: id, for: nextLevel)
        }
        storyController.tellStoryFor(level: level)
    case .buttonPressed:
        print("Button pressed")
        storageController.storeButtonPressed()
        storyController.tellIntroductionStory()
    case .exit:
        shouldExit = true
    case .unknown:
        print("Unknown input")
        continue
    }
}
