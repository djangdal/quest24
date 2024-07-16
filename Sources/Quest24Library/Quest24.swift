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
            // If we can't get a level from the value, start new quest
            guard let level = Level(rawValue: value) else {
                print("Starting quest for \(id)")
                rfidController.write(level: .level1)
                try! storageController.storeLevelUpgrade(id: id, for: .level1)
                return
            }

            // If they have just finished their level, except final level, upgrade them
            guard !level.isLevelFinished else {
                let nextLevel = level.nextLevel
                rfidController.write(level: nextLevel)
                try! storageController.storeLevelUpgrade(id: id, for: nextLevel)
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
    }
}
