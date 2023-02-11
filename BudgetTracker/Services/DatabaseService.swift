import Foundation;
import SQLite3;

class Database {
    private let dbPath: String;
    var db: OpaquePointer?;
    
    init() {
        self.dbPath = "transactions.sqlite";
        self.db = OpenDatabase();
        self.createLogTable();
        //self.createBankTable();
//        self.createCategoryTable();
        //self.dropTable(type: "Categories");
        //self.createTransactionsTable();
    }
    
    private func fetchFileUrl() -> String {
        let file: ExistFilePath = self.checkFile();
        let fileURL: String;
        
        if file.isExist {
            fileURL = file.path;
        } else {
            fileURL = try! FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(dbPath).path;
        }
        
        return fileURL;
    }
    
    private func OpenDatabase() -> OpaquePointer? {
        let fileURL: String = self.fetchFileUrl();

        if sqlite3_open(fileURL, &db) != SQLITE_OK {
            print("error opening database")
            notify(message: "error opening database");
            return nil;
        } else {
            print("Successfully opened connection to database at \(dbPath) \(fileURL)");
            return db;
        }
    }
    
    private func createTable(createQuery: String, table: Table) throws -> Void {
        if (createQuery.isEmpty) {
            throw "Query not provided or invalid";
        }
        
        if self.check(table: table) {
            print("\(table) was already created");
            Logger.create(title: "Already created", info: "\(table) was already created");
            return;
        }
        
        var createTableStatement: OpaquePointer? = nil;
        
        if sqlite3_prepare_v2(self.db, createQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            sqlite3_step(createTableStatement) == SQLITE_DONE ? print("\(table) table created.") : print("\(table) could not be created.");
//            notify(message: "\(table) create table prepared");
            Logger.create(title: "Table created done", info: "\(table) create table prepared");
        } else {
            print("CREATE TABLE statement for \(table) could not be prepared.");
            notify(message: "\(table) create table could not be prepared");
        }
        
        sqlite3_finalize(createTableStatement);
    }
    
    private func createLogTable() -> Void {
        let createLogQuery = "CREATE TABLE IF NOT EXISTS logs(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, information TEXT, date TEXT)";
        
        do {
            try self.createTable(createQuery: createLogQuery, table: .logs);
        } catch let error {
            print(error.localizedDescription);
        }
    }
    
    private func createTransactionsTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS transactions(
                id INTEGER PRIMARY KEY AUTOINCREMENT, rowId TEXT, categoryId INTEGER, description TEXT, toBankId INTEGER, amount INTEGER,
                type TEXT, fromBankId INTEGER, due INTEGER, date TEXT
            );
        """;
        
        do {
            try self.createTable(createQuery: createTableString, table: .transactions);
        } catch let error {
            print(error.localizedDescription);
        }
    }
    
    private func createTransactionsTableDup() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS transactions(
                id INTEGER PRIMARY KEY AUTOINCREMENT, category_id INTEGER, description TEXT, to_bank_id INTEGER, amount INTEGER, type TEXT, from_bank_id INTEGER, due INTEGER, date TEXT
            );
        """
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("transactions table created.")
            } else {
                print("transactions table could not be created.")
            }
        } else {
            print("CREATE TABLE transactions statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    private func createCategoryTable() {
        let createTableString = """
            CREATE TABLE IF NOT EXISTS categories(
                id INTEGER PRIMARY KEY AUTOINCREMENT, rowId TEXT, name TEXT, color TEXT, icon TEXT, description TEXT
            );
        """;
        
        do {
            try self.createTable(createQuery: createTableString, table: .categories);
        } catch let error {
            print(error.localizedDescription);
            Logger.create(title: "Error at create category table", info: error.localizedDescription);
        }
    }
    
    private func dropTable(type: String) {
        let deletQuery = "DROP TABLE IF EXISTS categories";
        var createTableStatement: OpaquePointer? = nil;
        
        if sqlite3_prepare_v2(self.db, deletQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            let isDone: Bool = sqlite3_step(createTableStatement) == SQLITE_DONE;
            isDone ? print("table deleted.") : print("table could not be deleted.");
        } else {
            print("DROP TABLE statement could not be prepared.");
        }
        
        sqlite3_finalize(createTableStatement);
    }
    
    private func createBankTable() {
        if self.check(table: .banks) {
            return;
        }
        
        let createTableString = """
            CREATE TABLE IF NOT EXISTS banks(
                id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT
            );
        """
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("banks table created.")
            } else {
                print("banks table could not be created.")
            }
        } else {
            print("CREATE TABLE banks statement could not be prepared.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    private func check(table: Table) -> Bool {
        let createTableString = "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='\(table)';"
        var createTableStatement: OpaquePointer? = nil
        var x: Int;
        
        if sqlite3_prepare_v2(self.db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            while sqlite3_step(createTableStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(createTableStatement, 0);
                x = Int(id);
                sqlite3_finalize(createTableStatement)
                return x > 0;
            }
        } else {
            print("Something wrong")
            sqlite3_finalize(createTableStatement)
            return false;
        }
        
        sqlite3_finalize(createTableStatement)
        return false;
    }
    
    private func checkFile() -> ExistFilePath {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0];
        let myFilePath = (documentDirectory as NSString).appendingPathComponent("transactions.sqlite")
        return ExistFilePath(
            isExist: FileManager.default.fileExists(atPath: myFilePath),
            path: myFilePath
        )
    }
}
