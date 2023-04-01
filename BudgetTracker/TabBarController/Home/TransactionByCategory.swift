import UIKit;

class TransactionsByCategoryView: UIView {
    private var parent = UIView();
    private let categoryName = UILabel();
    private let budgetLabel = UILabel();
    private let circle = UIView();
    private let iconLabel = UILabel();
    private let categoryTotal = UILabel();
    private let amountLabel = UILabel();
    
    private var categoryNameText: String;
    private var colorText: String;
    private var iconText: String;
    private var amountText: String;
    private var percenatage: Double;
    
    required init(cName: String, color: String, icon: String, amount: String, perc: Double) {
        self.categoryNameText = cName;
        self.colorText = color;
        self.iconText = icon;
        self.amountText = amount;
        self.percenatage = perc;
        
        super.init(frame: .zero);
    }
    
    required init?(coder: NSCoder) {
        self.categoryNameText = "";
        self.colorText = "";
        self.iconText = "";
        self.amountText = "";
        self.percenatage = 0;
        
        super.init(coder: coder);
    }
    
    override func didMoveToSuperview() {
        if (self.superview != nil) {
            self.parent = self.superview!;
            self.initalise();
        }
    }
    
    private func initalise() -> Void {
        translatesAutoresizingMaskIntoConstraints = false;
        widthAnchor.constraint(equalTo: parent.widthAnchor, constant: 0.9).isActive = true;
        heightAnchor.constraint(equalToConstant: 70).isActive = true;
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true;
//        layer.cornerRadius = 20;
//        backgroundColor = .green;
        addSubview(circle);
        addSubview(categoryName);
        addSubview(categoryTotal);
        addSubview(amountLabel);
        
        self.categoryCircleConstraints();
        self.categoryNameConstraints();
        self.categoryTotalConstraints();
        self.amountLabelConstraints();
    }
    
    private func categoryCircleConstraints() -> Void {
        circle.translatesAutoresizingMaskIntoConstraints = false;
        circle.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true;
        circle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        circle.addSubview(iconLabel);
        circle.backgroundColor = UIColor(hex: self.colorText);
        circle.layer.cornerRadius = 25;
        
        iconLabel.text = self.iconText.decode();
        iconLabel.translatesAutoresizingMaskIntoConstraints = false;
        iconLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true;
        iconLabel.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true;
        iconLabel.font = UIFont.systemFont(ofSize: 30);
    }
    
    private func categoryNameConstraints() -> Void {
        categoryName.translatesAutoresizingMaskIntoConstraints = false;
        categoryName.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15).isActive = true;
        categoryName.topAnchor.constraint(equalTo: circle.topAnchor, constant: 2).isActive = true;
        categoryName.text = self.categoryNameText;
        categoryName.font = .systemFont(ofSize: 18, weight: .bold);
        categoryName.textColor = .black;
    }
    
    private func categoryTotalConstraints() -> Void {
        categoryTotal.translatesAutoresizingMaskIntoConstraints = false;
        categoryTotal.leadingAnchor.constraint(equalTo: categoryName.leadingAnchor).isActive = true;
        categoryTotal.bottomAnchor.constraint(equalTo: circle.bottomAnchor, constant: -2).isActive = true;
        categoryTotal.text = "\(self.percenatage)% used from total";
        categoryTotal.font = .systemFont(ofSize: 13, weight: .regular);
        categoryTotal.textColor = .black;
    }
    
    private func amountLabelConstraints() -> Void {
        amountLabel.translatesAutoresizingMaskIntoConstraints = false;
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true;
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        amountLabel.text = self.numberFormatter(amount: self.amountText);
        amountLabel.font = .systemFont(ofSize: 18, weight: .semibold);
        amountLabel.textColor = .black;
    }
    
    private func numberFormatter(amount: String) -> String {
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .currency;
        numberFormatter.locale = Locale(identifier: "en_IN");
        numberFormatter.alwaysShowsDecimalSeparator = false;
        
        let value: String = numberFormatter.string(from: NSNumber(value: Int(amount)!))!;
        return value;
    }
}
