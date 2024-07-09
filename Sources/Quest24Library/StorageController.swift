final public class StorageController {

    private var storage = [Int: Level]()

    public init() {
    }
    
    public func hasStartedQuestFor(id: Int) -> Bool {
        //Retrieve the current highest level for the id
        return storage[id] != nil
    }

    public func levelFor(id: Int) -> Level? {
        return storage[id]
    }

    public func storeInvalidInput(id: Int, value: Int) {
        // Store in DB the id, value, and timestamp
    }

    public func storeButtonPressed() {
        // Store in DB a timestamp for button pressed
    }

    public func storeLevelUpgrade(id: Int, for level: Level) {
        guard !level.isLevelFinished else { return }
        storage[id] = level
        //Store the level for the rfid in DB with timestamp
    }
}
