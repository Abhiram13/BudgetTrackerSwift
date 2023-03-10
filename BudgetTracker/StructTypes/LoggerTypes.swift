import UIKit;

struct LoggerType: Codable {
    let id: Int;
    let title: String;
    let information: String;
    let date: String;
}

struct LoggerInsert {
    let title: String;
    let information: String;
}
