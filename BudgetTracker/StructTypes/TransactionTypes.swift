
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
