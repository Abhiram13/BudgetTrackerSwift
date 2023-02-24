import SwiftUI;
import Foundation;

struct InsertTransaction: View {
    @Environment(\.colorScheme) var colorScheme;
    @State private var showWarningAlert: Bool = false;
    @State private var alertMessage: String = "";
    @State private var description: String = "";
    @State private var amount: Int = 0;
    @State private var categories: [CategorySelectableList] = [CategorySelectableList(rowId: "", name: "")];
    @State private var banks: [BankSelectableList] = [BankSelectableList(rowId: "", name: "")];
    @State private var selectedCategory: CategorySelectableList = CategorySelectableList(rowId: "", name: "");
    @State private var selectedBank: BankSelectableList = BankSelectableList(rowId: "", name: "");
    @State private var selectedToBank: BankSelectableList = BankSelectableList(rowId: "", name: "");
    @State private var selectedDate: Date = Date();
    @State private var isDue: Bool = false;
    @State private var type: TypeOfTransaction = TypeOfTransaction(label: .Debit, value: .debit);
    @State private var transactionTypes: [TypeOfTransaction] = [
        TypeOfTransaction(label: .Debit, value: .debit),
        TypeOfTransaction(label: .Credit, value: .credit),
        TypeOfTransaction(label: .PartialDebit, value: .partialDebit),
        TypeOfTransaction(label: .PartialCredit, value: .partialCredit)
    ];
//    let categoryHelper: CategoryHelper = CategoryHelper();
//    let bankHelper: BankHelper = BankHelper();
//    let transactionHelper: TransactionHelper = TransactionHelper();
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", value: self.$amount, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                
                TextField("Description", text: self.$description)
                    .keyboardType(.asciiCapable)
                
                Picker("Transaction Type", selection: $type) {
                    ForEach(self.transactionTypes, id: \.label) { typ in Text(typ.label.rawValue).tag(typ as TypeOfTransaction) }
                }
                .onChange(of: type) { t in print("This is selected type: \(t)") }
            }
            
            Section {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(self.categories, id: \.name) { c in Text(c.name).tag(c as CategorySelectableList) }
                }
                .onChange(of: selectedCategory) { cat in print("This is selected category: \(cat)") }
                
                Picker("From Bank", selection: $selectedBank) {
                    ForEach(self.banks, id: \.name) { b in Text(b.name).tag(b as BankSelectableList) }
                }
                .onChange(of: selectedBank) { bank in print("This is selected bank: \(bank)") }
                
                Picker("To Bank", selection: $selectedToBank) {
                    ForEach(self.banks, id: \.name) { bk in Text(bk.name).tag(bk as BankSelectableList) }
                }
                .onChange(of: selectedToBank) { bnk in print(bnk) }
            }
            
            Section {
                DatePicker("Transaction Date", selection: $selectedDate, displayedComponents: .date)
            }
            
            Section {
                Toggle("Transaction Due", isOn: $isDue)
            }
            
            Button("Submit") {
                self.Save()
            }
            .alert(self.alertMessage, isPresented: $showWarningAlert) {
                Button("OK", role: .cancel) {}
            }
        }
//        .toolbar(.hidden, for: .tabBar)
//        .frame(alignment: .topLeading)
//        .onAppear(perform: self.LoadData)
    }
    
    private func LoadData() -> Void {
//        var bks = bankHelper.read();
        
//        bks.map {
//            bankHelper.update(payload: Bank(id: $0.id, name: $0.name, row_id: $0.row_id == "" ? UUID().uuidString : $0.row_id))
//        }
//
//        cts.map {
//            categoryHelper.update(payload: Category(id: $0.id, category: $0.category, row_id: $0.row_id == "" ? UUID().uuidString : $0.row_id))
//        }
//        bks.insert(Bank(id: 0, name: "None", row_id: ""), at: 0);
//        self.categories = categoryHelper.read();
//        self.banks = bks;
    }
    
    private func Save() -> Void {
//        let formatter = DateFormatter();
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss";
//        let isDetailsProvided: Bool =  self.AlertMessage()
//
//        print("catgs_id: \(self.selectedCategory)")
//        print("bank_id: \(self.selectedBank)")
//        print("bank_id_to: \(self.selectedToBank)")
//
//        if isDetailsProvided {
//            let isSuccess: Bool = transactionHelper.insert(payload: Transaction(
//                id: 1,
//                amount: self.amount,
//                description: self.description,
//                type: self.type.value,
//                to_bank_id: self.selectedToBank.row_id,
//                from_bank_id:  self.selectedBank.row_id,
//                category_id: self.selectedCategory.row_id,
//                date: formatter.string(from: self.selectedDate),
//                due: self.isDue ? 1 : 0,
//                row_id: UUID().uuidString
//            ))
//
//            self.alertMessage = isSuccess ? "Transaction was added" : "Transaction could not be added";
//            self.showWarningAlert = true;
//        }
    }
    
    private func AlertMessage() -> Bool {
//        if self.description == "" {
//            self.showWarningAlert = true;
//            self.alertMessage = "Please provide description";
//            return false;
//        } else if self.amount == 0 {
//            self.showWarningAlert = true;
//            self.alertMessage = "Please provide amount";
//            return false;
//        }
//        else if self.selectedCategory.id == 0 {
//            self.showWarningAlert = true;
//            self.alertMessage = "Please provide category";
//            return false;
//        }
//
        return true;
    }
}
