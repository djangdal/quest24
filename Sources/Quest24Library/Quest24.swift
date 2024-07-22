import Foundation

public final class Quest24 {
    private let pinController: PinController
    private let storyController: StoryController
    private let storageController: StorageController
    private let rfidController: RFIDControllerProtocol

    public init(
        pinController: PinController,
        storyController: StoryController,
        storageController: StorageController,
        rfidController: RFIDControllerProtocol
    ) {
        self.pinController = pinController
        self.storyController = storyController
        self.storageController = storageController
        self.rfidController = rfidController
    }

    public func tick(input: InputType) {
        do {
            switch input {
            case .rfid(let id, let value):
                // If we can't get a level from the value, start new quest if we haven't
                guard let level = Level(rawValue: value) else {
                    guard try !storageController.hasStartedQuestFor(id: id) else { return }
                    print("Starting quest for \(id)")
                    pinController.showLightsFor(level: .level1)
                    rfidController.write(level: .level1)
                    try storageController.storeLevelUpgrade(id: id, for: .level1)
                    storyController.tellGameStart()
                    return
                }

                // If they have just finished their level, except final level, upgrade them
                if level.isLevelFinished {
                    let nextLevel = level.nextLevel
                    rfidController.write(level: nextLevel)
                    pinController.showLightsFor(level: level)
                    try storageController.storeLevelUpgrade(id: id, for: nextLevel)
                    storyController.tellStoryFor(level: level)
                    return
                }

                pinController.showLightsFor(level: level)
                storyController.tellStoryFor(level: level)

            case .buttonPressed:
                print("Button pressed")
                storyController.tellIntroductionStory()

            case .exit:
                return

            case .unknown:
                print("Unknown input")
                return
            }
        } catch {
            print("Found error: \(error)")
        }
    }
}
