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
                    ForEach(self.categories, id: \.rowId) { c in Text(c.name).tag(c as CategorySelectableList) }
                }
                .onChange(of: selectedCategory) { cat in print("This is selected category: \(cat)") }
                
                Picker("From Bank", selection: $selectedBank) {
                    ForEach(self.banks, id: \.rowId) { b in Text(b.name).tag(b as BankSelectableList) }
                }
                .onChange(of: selectedBank) { bank in print("This is selected bank: \(bank)") }
                
                Picker("To Bank", selection: $selectedToBank) {
                    ForEach(self.banks, id: \.rowId) { bk in Text(bk.name).tag(bk as BankSelectableList) }
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
        .onAppear(perform: self.LoadData)
    }
    
    private func LoadData() -> Void {
        let listOfCategories: [CategorySelectableList] = Categories.selectableList();
        let listOfBanks: [BankSelectableList] = BankServices.listWithId();
        
        self.categories = listOfCategories;
        self.banks = listOfBanks;
        self.selectedCategory = listOfCategories[0];
        self.selectedBank = listOfBanks[0];
        self.selectedToBank = listOfBanks[0];
        
        print("Categories: \(self.categories)")
        print("Bank: \(self.banks)")
    }
    
    private func Save() -> Void {
//        let isDetailsProvided: Bool =  self.AlertMessage()
//
        print("Category: \(self.selectedCategory.name)")
        print("From bank: \(self.selectedBank.name)")
        print("To Bank: \(self.selectedToBank.name)")
        print("Amount: \(amount)")
        print("Description: \(description)")
        print("Type: \(type.value)")
        print("Date: \(DateController.convertToString(date: selectedDate))");
        print("Due: \(isDue)");
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
