import UIKit;
import SQLite3;

class Logger {
    private static let db: OpaquePointer = Database().db!;
    
    private static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
    
    static func create(title: String, info: String) -> Void {
        let insertStatementString = "INSERT INTO logs (title, information, date) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (info as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (getCurrentDate() as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully created log.")
                sqlite3_finalize(insertStatement);
            } else {
                print("Could not insert the log.")
                sqlite3_finalize(insertStatement);
            }
        } else {
            print("INSERT log statement could not be prepared.")
            sqlite3_finalize(insertStatement);
        }
        
        sqlite3_finalize(insertStatement);
    }
}
