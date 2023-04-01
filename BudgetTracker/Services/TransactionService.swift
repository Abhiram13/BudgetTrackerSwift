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

    static func list(month: String? = nil, year: String? = nil) -> [TransactionByCategories] {
        let month: String = month ?? DateController.currentMonth;
        let year: String = year ?? DateController.currentYear;
        
        let queryStatementString = """
            SELECT
                COALESCE(SUM(t.amount), 0) as amount,
                c.rowId, c.name, c.icon, c.color
            FROM transactions t
            LEFT JOIN categories c ON c.rowId = t.categoryId
            WHERE strftime('%m', t.date) = '\(month)' AND strftime('%Y', t.date) = '\(year)'
            GROUP BY t.categoryId
        """
        var queryStatement: OpaquePointer? = nil
        var transactions: [TransactionByCategories] = []
        let montlyAmount = 50000;

        if sqlite3_prepare_v2(self.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let amount = sqlite3_column_int(queryStatement, 0);
                let categoryRowId = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)));
                let categoryName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)));
                let categoryIcon = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)));
                let categoryColor = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)));
                let decimal = Double(amount)/Double(montlyAmount) * 100
                let perc = decimal                
                
                transactions.append(TransactionByCategories(
                    categoryId: categoryRowId,
                    categoryIcon: categoryIcon,
                    categoryColor: categoryColor,
                    categoryName: categoryName,
                    amount: Int(amount),
                    transactionsCount: 0,
                    percOfTotal: perc
                ));
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
