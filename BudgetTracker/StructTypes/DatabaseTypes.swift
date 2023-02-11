import UIKit;

struct ExistFilePath {
    let isExist: Bool;
    let path: String;
}

enum Table: String {
    case transactions = "transactions";
    case categories = "categories";
    case banks = "banks";
    case logs = "logs";
}

extension String: Error {};

enum MyError: Error {
    case runtimeError(String)
}
