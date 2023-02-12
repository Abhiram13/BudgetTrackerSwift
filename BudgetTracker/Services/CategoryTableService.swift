import SQLite3;
import Foundation;

class Categories {
    private static let db = Database().db;
    
    static func insert(payload: Category) -> StatusCode {
        let insertStatementString = "INSERT INTO categories (rowId, name, icon, color, description) VALUES (?, ?, ?, ?, ?);";
        
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (UUID().uuidString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (payload.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (payload.icon as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (payload.color as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (payload.description as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                Logger.create(title: "Row insert", info: "Successfully inserted category");
                sqlite3_finalize(insertStatement);
                return .Ok;
            } else {
                print("Could not insert row.")
                Logger.create(title: "Row insert failed", info: "Cannot able to insert category");
                sqlite3_finalize(insertStatement);
                return .NotPerformed;
            }
        } else {
            print("INSERT statement could not be prepared.")
            Logger.create(title: "Insert statement error", info: "INSERT statement could not be prepared at categories.");
            sqlite3_finalize(insertStatement);
            return .NotPerformed;
        }
    }
    
    static func list() -> [CategoryWithId] {
        let queryStatementString = "SELECT id, COALESCE(rowId, ''), COALESCE(name, ''), COALESCE(icon, ''), COALESCE(color, ''), COALESCE(description, '') FROM categories;"
        var queryStatement: OpaquePointer? = nil
        var categories : [CategoryWithId] = []
        
        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0);
                let row_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)));
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)));
                let icon = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)));
                let color = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)));
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)));
                
                print("id: \(id)");
                print("row_id: \(row_id)");
                print("name: \(name)");
                print("icon: \(icon)");
                print("color: \(color)");
                print("description: \(description)");
                
                categories.append(CategoryWithId(id: Int(id), rowId: row_id, name: name, description: description, icon: icon, color: color));
            }
        } else {
            print("SELECT statement could not be prepared")
            Logger.create(title: "SELECT statement error", info: "SELECT statement could not be prepared at categories.");
        }
        
        sqlite3_finalize(queryStatement)
        return categories;
    }
    
    static func deleteAll() -> Void {
        let deleteStatementString = "DELETE FROM categories";
        var deleteStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(self.db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                Logger.create(title: "Deleted row", info: "DELETE statement at categories.");
            } else {
                Logger.create(title: "Delete failed", info: "Cannot delete at categories.");
            }
        } else {
            Logger.create(title: "Delete statement error", info: "DELETE statement could not be prepared");
        }
        
        sqlite3_finalize(deleteStatement)
    }
}
