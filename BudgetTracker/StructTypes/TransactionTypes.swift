import UIKit;

struct TypeOfTransaction: Hashable {
    let label: LabelOfTransactionTypes;
    let value: ValueOfTransactionTypes;
}

enum ValueOfTransactionTypes: String {
    case debit = "debit"
    case credit = "credit"
    case partialCredit = "partialCredit"
    case partialDebit = "partialDebit"
}

enum LabelOfTransactionTypes: String {
    case Debit = "Debit"
    case Credit = "Credit"
    case PartialCredit = "Partial Credit"
    case PartialDebit = "Partial Debit"
}

class TransactionPayload {
    let categoryId: String;
    let fromBankId: String;
    let toBankId: String;
    let description: String;
    let amount: Int32;
    let type: String;
    let due: Int32;
    let date: String;
    
    init(categoryId: String, fromBankId: String, toBankId: String, description: String, amount: Int32, type: String, due: Int32, date: String) {
        self.categoryId = categoryId
        self.fromBankId = fromBankId
        self.toBankId = toBankId
        self.description = description
        self.amount = amount
        self.type = type
        self.due = due
        self.date = date
    }
}

class TransactionWithId: TransactionPayload {
    let rowId: String;
    
    init(rowId: String, categoryId: String, fromBankId: String, toBankId: String, description: String, amount: Int32, type: String, due: Int32, date: String) {
        self.rowId = rowId;
        super.init(categoryId: categoryId, fromBankId: fromBankId, toBankId: toBankId, description: description, amount: amount, type: type, due: due, date: date)
    }
}

//class Transaction: TransactionPayload {
//    let rowId: String;
//    
//    override init(categoryId: String, fromBankId: String, toBankId: String, description: String, amount: Int, type: String, due: Bool, date: String) {
//        
//    }
//}
