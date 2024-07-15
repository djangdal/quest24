import XCTest
@testable import Quest24Library

class StorageTests: XCTestCase {
    
    func testStorage_whenInit_noLevelStored() throws {
        let storageController = try StorageController()
        let hasStarted = try storageController.hasStartedQuestFor(id: 1)
        XCTAssertFalse(hasStarted)
    }
    
    func testStorage_whenStoredLevel_hasStartedQuest() throws {
        let storageController = try StorageController(file: "/Users/DJANGDAL/Documents/Quest24/Tests/Quest24Tests/db.sqlite")
        try storageController.storeLevelUpgrade(id: 1, for: .level1)
        let hasStarted = try storageController.hasStartedQuestFor(id: 1)
        XCTAssertTrue(hasStarted)
    }
    
    func testStorage_whenStoredLevel_readCorrectLevel() throws {
        let storageController = try StorageController()
        try storageController.storeLevelUpgrade(id: 1, for: .level3)
        let level = try storageController.levelFor(id: 1)
        XCTAssertEqual(level, .level3)
    }
    
    func testStorage_whenStoredMultipleLevels_readLatestLevel() throws {
        let storageController = try StorageController(file: "/Users/DJANGDAL/Documents/Quest24/Tests/Quest24Tests/db.sqlite")
        try storageController.storeLevelUpgrade(id: 43, for: .level1)
        try storageController.storeLevelUpgrade(id: 43, for: .level2)
        try storageController.storeLevelUpgrade(id: 43, for: .level3)
        try storageController.storeLevelUpgrade(id: 43, for: .level4)
        let level = try storageController.levelFor(id: 43)
        XCTAssertEqual(level, .level4)
    }
}
