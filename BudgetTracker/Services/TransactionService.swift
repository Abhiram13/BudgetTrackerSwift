import UIKit;
import SQLite3;

class TransactionServices {
    private static let db = Database().db;

    static func insert(payload: TransactionPayload) -> StatusCode {
        let insertStatementString = "INSERT INTO transactions (rowId, categoryId, description, toBankId, amount, type, fromBankId, due, date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);";

        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (UUID().uuidString as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (payload.categoryId as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (payload.description as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (payload.toBankId as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 5, payload.amount)
            sqlite3_bind_text(insertStatement, 6, (payload.type as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (payload.fromBankId as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 8, payload.due)
            sqlite3_bind_text(insertStatement, 9, (payload.date as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                Logger.create(title: "Row insert", info: "Successfully inserted transaction");
                sqlite3_finalize(insertStatement);
                return .Ok;
            } else {
                Logger.create(title: "Row insert failed", info: "Cannot able to insert transaction");
                sqlite3_finalize(insertStatement);
                return .NotPerformed;
            }
        } else {
            Logger.create(title: "Insert statement error", info: "INSERT statement could not be prepared at transaction table.");
            sqlite3_finalize(insertStatement);
            return .NotPerformed;
        }
    }

    static func list() -> [TransactionWithId] {
        let queryStatementString = """
            SELECT COALESCE(rowId, ''), COALESCE(categoryId, ''), COALESCE(description, ''), COALESCE(toBankId, ''), amount, COALESCE(type, ''),
            COALESCE(fromBankId, ''), due, COALESCE(date, '') FROM transactions;
        """
        var queryStatement: OpaquePointer? = nil
        var transactions: [TransactionWithId] = []

        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let row_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)));
                let category = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)));
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)));
                let toBank = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)));
                let amount = sqlite3_column_int(queryStatement, 4);
                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)));
                let fromBank = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)));
                let due = sqlite3_column_int(queryStatement, 7);
                let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)));

                transactions.append(TransactionWithId(
                    rowId: row_id,
                    categoryId: category,
                    fromBankId: fromBank,
                    toBankId: toBank,
                    description: description,
                    amount: amount,
                    type: type,
                    due: due,
                    date: date
                ))
            }
        } else {
            Logger.create(title: "SELECT statement error", info: "SELECT statement could not be prepared at transaction list.");
        }

        sqlite3_finalize(queryStatement)
        return transactions;
    }

//    static func listWithId() -> [BankSelectableList] {
//        let queryStatementString = "SELECT COALESCE(rowId, ''), COALESCE(name, '') FROM banks;"
//        var queryStatement: OpaquePointer? = nil
//        var banks: [BankSelectableList] = []
//        let emptyBank = BankSelectableList(rowId: "", name: "None");
//
//        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                let row_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)));
//                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)));
//
//                banks.append(BankSelectableList(rowId: row_id, name: name));
//            }
//        } else {
//            Logger.create(title: "SELECT statement error", info: "SELECT statement could not be prepared at bank list with id.");
//        }
//
//        sqlite3_finalize(queryStatement)
//        banks.insert(emptyBank, at: 0);
//        return banks.count > 0 ? banks : [emptyBank];
//    }
}
