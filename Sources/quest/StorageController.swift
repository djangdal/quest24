final class StorageController {
    func storeInvalidInput(id: Int, value: Int) {
        // Store in DB the id, value, and timestamp
    }

    func storeButtonPressed() {
        // Store in DB a timestamp for button pressed
    }

    func storeLevelUpgrade(id: Int, for level: Level) {
        guard !level.isLevelFinished else { return }
        //Store the level for the rfid in DB with timestamp
    }
}
