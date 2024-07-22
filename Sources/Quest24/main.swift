import Foundation
import Quest24Library

let pinController = PinController()
let soundPlayer = SoundPlayer()
let storyController = StoryController(soundPlayer: soundPlayer)
let storageController = try! StorageController(file: ".quest24-borderland.sqlite3")
let rfidController = RFIDController()
let inputController = InputController(pinController: pinController, rfidController: rfidController)
let quest24 = Quest24(
    pinController: pinController,
    storyController: storyController,
    storageController: storageController,
    rfidController: rfidController
)

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
    let input = inputController.getInput()
    guard input != .exit else {
        shouldExit = true
        continue
    }
    quest24.tick(input: input)
    pinController.allLightsOff()
}
