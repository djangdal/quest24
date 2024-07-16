import XCTest
@testable import Quest24Library

class QuestTests: XCTestCase {

    private var soundPlayer: MockSoundPlayer!
    private var pinController: PinController!
    private var storyController: StoryController!
    private var storageController: StorageController!
    private var rfidController: MockRFIDController!
    private var inputController: InputController!
    private var quest: Quest24!

    override func setUp() {
        super.setUp()
        self.soundPlayer = MockSoundPlayer()
        self.pinController = PinController()
        self.storyController = StoryController(soundPlayer: soundPlayer)
        self.storageController = try! StorageController(file: ":memory:")
        self.rfidController = MockRFIDController()
        self.inputController = InputController(pinController: pinController, rfidController: rfidController)
        self.quest = Quest24(
            pinController: pinController,
            storyController: storyController,
            storageController: storageController,
            rfidController: rfidController
        )
    }

    // Add a test where the write of starting and/or new level is successfull
    //Verify that new level is written before showing those instructions

    func testQuest_unseenCard_haveStartedQuest() {
        quest.tick(input: .rfid(id: 1, value: 3232342))
        let hasStarted1 = try! storageController.hasStartedQuestFor(id: 1)
        let hasStarted0 = try! storageController.hasStartedQuestFor(id: 0)
        XCTAssertTrue(hasStarted1)
        XCTAssertFalse(hasStarted0)
    }

    func testQuest_whenStoredLevel_hasStartedQuest() {
        try! storageController.storeLevelUpgrade(id: 23, for: .level2)
        quest.tick(input: .rfid(id: 23, value: Level.finishedLevel2.rawValue))
        let level = try! storageController.levelFor(id: 23)
        XCTAssertEqual(level, .level3)
    }

    func testQuest_questChain() {
        quest.tick(input: .rfid(id: 10, value: 21221))
        XCTAssertEqual(Level.level1, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level1)

        quest.tick(input: .rfid(id: 10, value: 15))
        XCTAssertEqual(rfidController.writtenLevel, .level2)

        quest.tick(input: .rfid(id: 10, value: 25))
        XCTAssertEqual(rfidController.writtenLevel, .level3)
    }

    func testQuest_firstTimeWithLevel1Finished() {
        quest.tick(input: .rfid(id: 10, value: 15))
        XCTAssertEqual(Level.level2, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level2)
    }

    func testQuest_firstTimeWithLevel2Finished() {
        quest.tick(input: .rfid(id: 10, value: 25))
        XCTAssertEqual(Level.level3, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level3)
    }

    func testQuest_firstTimeWithLevel3Finished() {
        quest.tick(input: .rfid(id: 10, value: 35))
        XCTAssertEqual(Level.level4, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level4)
    }

    func testQuest_firstTimeWithLevel4Finished() {
        quest.tick(input: .rfid(id: 10, value: 45))
        XCTAssertEqual(Level.level5, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level5)
    }

    func testQuest_firstTimeWithLevel5Finished() {
        quest.tick(input: .rfid(id: 10, value: 55))
        XCTAssertEqual(Level.completed, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .completed)
    }

    func testQuest_unknownNumber_shouldStartQuest() {
        quest.tick(input: .rfid(id: 10, value: 127))
        XCTAssertEqual(Level.level1, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level1)
    }

    func testQuest_unknownNumberLow_shouldStartQuest() {
        quest.tick(input: .rfid(id: 10, value: 2))
        XCTAssertEqual(Level.level1, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level1)
    }

    func testQuest_zero_shouldStartQuest() {
        quest.tick(input: .rfid(id: 10, value: 0))
        XCTAssertEqual(Level.level1, try! storageController.levelFor(id: 10))
        XCTAssertEqual(rfidController.writtenLevel, .level1)
    }
}

final class MockSoundPlayer: SoundPlayerProtocol {
    func play(sound: Quest24Library.Sound) {
    }
}

final class MockRFIDController: RFIDControllerProtocol {
    var writtenLevel: Level?
    func read() -> (Int, Int)? {
        return nil
    }

    func write(level: Quest24Library.Level) {
        self.writtenLevel = level
    }
}
