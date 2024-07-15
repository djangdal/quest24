import SQLite

final public class StorageController {

    private var storage = [Int: Level]()
    private var db: Connection

    private var user_quests = Table("user_quests")
    let col_id = Expression<Int>("id")
    let col_level = Expression<Int>("level")
    // let timestamp = Expression<NSDate>("inserted")

    public init() throws {
        db = try Connection("/home/djangdal/.local/var/quest24.sqlite3")
        try migrate()
    }

    private func migrate() throws {
        try db.run(user_quests.create(ifNotExists: true) { t in
            t.column(col_id, primaryKey: true)
            t.column(col_level)
        })
    }
    /*
        // We only add to the DB, no update. Then we sort o
        UserID, currentQuestLevel, timestamp 
    */
    
    public func hasStartedQuestFor(id: Int) throws -> Bool {
        //Retrieve the current highest level for the id
        return try db.scalar(user_quests.filter(col_id == id).count) != 0
    }

    public func levelFor(id: Int) throws -> Level? {
        if let user = try db.pluck(user_quests.filter(col_id == id)) {
            return Level(rawValue: user[col_level])
        }
        return nil
    }

    public func storeLevelUpgrade(id: Int, for level: Level) throws {
        guard !level.isLevelFinished else { return }
        try db.run(user_quests.filter(col_id == id).update(col_level <- level.rawValue))
        
        //Store the level for the rfid in DB with timestamp
    }


    public func storeInvalidInput(id: Int, value: Int) {
        // Store in DB the id, value, and timestamp
    }

    public func storeButtonPressed() {
        // Store in DB a timestamp for button pressed
    }
}
