import UIKit;
import SQLite3;

struct LoggerStorage {
    static let key = "logsKey";
}

class Storage {
    private let key: String;
    private let defaults: UserDefaults;
    
    init(key: String) {
        self.key = key
        self.defaults = UserDefaults.standard;
    }
    
    func set<T: Encodable>(data: T) {
        self.defaults.set(try? PropertyListEncoder().encode(data), forKey: self.key);
    }
    
    func get<T: Decodable>() -> T? {
        if let data = UserDefaults.standard.value(forKey: self.key) as? Data {
            let logs = try? PropertyListDecoder().decode(T.self, from: data);
            return logs;
        }
        
        return nil;
    }
    
    func remove() {
        defaults.removeObject(forKey: key);
    }
}

class Logger {
    private static let db: OpaquePointer = Database().db!;
    private static let storage = Storage(key: LoggerStorage.key);
    
    private static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormats.shortDateWithTimePeriod.rawValue;
        return dateFormatter.string(from: Date())
    }
    
    static func create(title: String, info: String) -> Void {
        let data: [LoggerType]? = storage.get();
        var arrayOfLogs: [LoggerType] = data != nil ? data! : [];
        let log = LoggerType(id: arrayOfLogs.count + 1, title: title, information: info, date: getCurrentDate());
        arrayOfLogs.append(log);
        
        storage.set(data: arrayOfLogs);
    }
    
    static func list() -> [LoggerType] {
        let data: [LoggerType]? = storage.get();
        let logs: [LoggerType] = data != nil ? data! : [];
        return logs.sorted {$0.id > $1.id};
    }
}
