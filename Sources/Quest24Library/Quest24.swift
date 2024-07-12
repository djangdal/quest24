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
        switch input {
        case .rfid(let id, let value):
            // If we don't have a level stored for id, start a new quest
            guard storageController.hasStartedQuestFor(id: id) else {
                print("Starting quest for \(id)")
                rfidController.write(level: .level1)
                // Should check here that write was successfull
                storageController.storeLevelUpgrade(id: id, for: .level1)
                pinController.showLightsFor(level: .level1)
                storyController.tellStoryFor(level: .level1)
                return
            }

            // If we can't get a level from the value, show error
            guard let level = Level(rawValue: value) else {
                storageController.storeInvalidInput(id: id, value: value)
                pinController.showAllRed()
                print("Invalid input of level, id: \(id), value: \(value)")
                return
            }

            // If they have just finished their level, except final level, upgrade them
            if level.isLevelFinished {
                let nextLevel = level.nextLevel
                rfidController.write(level: nextLevel)
                // Check here that the new level was written
                storageController.storeLevelUpgrade(id: id, for: nextLevel)
            }
            pinController.showLightsFor(level: level)
            storyController.tellStoryFor(level: level)

        case .buttonPressed:
            print("Button pressed")
            storageController.storeButtonPressed()
            storyController.tellIntroductionStory()

        case .exit:
            return

        case .unknown:
            print("Unknown input")
            return
        }
    }
}
