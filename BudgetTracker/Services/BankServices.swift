import UIKit;
import SQLite3;

class BankServices {
    private static let db = Database().db;
    
    static func insert(bank name: String) -> StatusCode {
        let insertStatementString = "INSERT INTO banks (rowId, name) VALUES (?, ?);";
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (UUID().uuidString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                Logger.create(title: "Row insert", info: "Successfully inserted bank");
                sqlite3_finalize(insertStatement);
                return .Ok;
            } else {
                Logger.create(title: "Row insert failed", info: "Cannot able to insert bank");
                sqlite3_finalize(insertStatement);
                return .NotPerformed;
            }
        } else {
            Logger.create(title: "Insert statement error", info: "INSERT statement could not be prepared at bank table.");
            sqlite3_finalize(insertStatement);
            return .NotPerformed;
        }
    }
    
    static func list() -> [BankWithId] {
        let queryStatementString = "SELECT id, COALESCE(rowId, ''), COALESCE(name, '') FROM banks;"
        var queryStatement: OpaquePointer? = nil
        var banks: [BankWithId] = []
        
        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0);
                let row_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)));
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)));
                
                print("id: \(id)");
                print("row_id: \(row_id)");
                print("name: \(name)");
                
                banks.append(BankWithId(id: Int(id), rowId: row_id, name: name));
            }
        } else {
            print("SELECT statement could not be prepared")
            Logger.create(title: "SELECT statement error", info: "SELECT statement could not be prepared at categories.");
        }
        
        sqlite3_finalize(queryStatement)
        return banks;
    }
}
