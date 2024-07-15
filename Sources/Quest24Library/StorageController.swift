import Foundation
import SQLite

final public class StorageController {

    private var storage = [Int: Level]()
    private var db: Connection

    private var user_quests = Table("user_quests")
    let col_id = Expression<Int>("id")
    let col_level = Expression<Int>("level")
    let timestamp = Expression<Date>("inserted")

    public init(file: String? = nil) throws {
        if let file {
            db = try Connection(file)
        } else {
            db = try Connection()
        }
        try migrate()
    }

    private func migrate() throws {
        try db.run(user_quests.create(ifNotExists: true) { t in
            t.column(col_id)
            t.column(col_level)
            t.column(timestamp)
        })
    }
    /*
        // We only add to the DB, no update. Then we sort o
        UserID, currentQuestLevel, timestamp 
    */
    
    public func hasStartedQuestFor(id: Int) throws -> Bool {
        //Retrieve the current highest level for the id
        let users = user_quests.filter(col_id == id)
        let count = users.count
        let something = try db.scalar(count)
        return something != 0
    }

    public func levelFor(id: Int) throws -> Level? {
        if let user = try db.pluck(user_quests.filter(col_id == id).order(timestamp.desc, col_level.desc)) {
            return Level(rawValue: user[col_level])
        }
        return nil
    }

    public func storeLevelUpgrade(id: Int, for level: Level) throws {
        try db.run(user_quests.insert(col_id <- id, col_level <- level.rawValue, timestamp <- Date()))
//        guard !level.isLevelFinished else { return }
//        try db.run(user_quests.filter(col_id == id).update(col_level <- level.rawValue))
        
        //Store the level for the rfid in DB with timestamp
    }


    public func storeInvalidInput(id: Int, value: Int) {
        // Store in DB the id, value, and timestamp
    }

    public func storeButtonPressed() {
        // Store in DB a timestamp for button pressed
    }
}
