import XCTest
@testable import Quest24Library

class StorageTests: XCTestCase {

    func testStorage_whenInit_noLevelStored() {
        let storageController = StorageController()
        let hasStarted = storageController.hasStartedQuestFor(id: 1)
        XCTAssertFalse(hasStarted)
    }

    func testStorage_whenStoredLevel_hasStartedQuest() {
        let storageController = StorageController()
        storageController.storeLevelUpgrade(id: 1, for: .level1)
        let hasStarted = storageController.hasStartedQuestFor(id: 1)
        XCTAssertTrue(hasStarted)
    }

    func testStorage_whenStoredLevel_readCorrectLevel() {
        let storageController = StorageController()
        storageController.storeLevelUpgrade(id: 1, for: .level3)
        let level = storageController.levelFor(id: 1)
        XCTAssertEqual(level, .level3)
    }
}
