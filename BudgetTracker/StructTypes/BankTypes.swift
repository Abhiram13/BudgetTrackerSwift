
struct BankSelectableList: Decodable, Hashable {
    let rowId: String;
    let name: String;
}

class Bank {
    let rowId: String;
    let name: String;
    
    init(rowId: String, name: String) {
        self.rowId = rowId
        self.name = name
    }
}

class BankWithId: Bank {
    let id: Int;
    
    init(id: Int, rowId: String, name: String) {
        self.id = id;
        super.init(rowId: rowId, name: name);
    }
}
