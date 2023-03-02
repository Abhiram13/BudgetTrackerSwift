import UIKit
import SwiftUI;

class HomeViewController: UIViewController {
    let reportView = ReportView();
    let addButton = AddButton();
    var transactions: [TransactionByCategories] = [];
    let scrollView = UIScrollView();
    let stackView = UIStackView();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = .SystemBasedBg;
        view.addSubview(scrollView);
        view.addSubview(addButton);
        
        self.scrollViewConstraints();
        self.stackViewConstraints();
        
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        addButton.addTarget(self, action: #selector(navigateToAddView), for: .touchDown)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        transactions = TransactionServices.list();
        
        print(transactions);
        
        self.addTransactionsToStackView();
        self.tabBarController?.tabBar.isHidden = false;
    }
    
    private func scrollViewConstraints() -> Void {
        scrollView.addSubview(reportView);
        scrollView.addSubview(stackView);
        scrollView.translatesAutoresizingMaskIntoConstraints = false;
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000);
    }
    
    private func stackViewConstraints() -> Void {
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 20;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: reportView.bottomAnchor, constant: 20).isActive = true;
        stackView.widthAnchor.constraint(equalTo: reportView.widthAnchor).isActive = true;
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true;
//        stackView.backgroundColor = .red;
    }
    
    private func addTransactionsToStackView() -> Void {
        self.removeTransactionsFromStackView();
        
        for _ in transactions {
            stackView.addArrangedSubview(TransactionView());
        }
    }
    
    private func removeTransactionsFromStackView() -> Void {
        stackView.subviews.forEach { transactionView in
            transactionView.removeFromSuperview();
        }
    }
    
    @objc private func navigateToAddView() {
        let insertTransactionView = UIHostingController(rootView: InsertTransaction());
        self.navigationController?.pushViewController(insertTransactionView, animated: true);
        self.tabBarController?.tabBar.isHidden = true;
    }
    
    @objc private func notify(_ notification: Notification) {
        let alert: UIAlertController = AlertController(message: notification.userInfo!["error"] as! String);
        self.present(alert, animated: true, completion: nil)
        print("This alert has been notified");
        print("Alert message is: \(notification.userInfo!["error"] as! String)");
    }
}

class ReportView: UIView {
    private var parent = UIView();
    private let label = UILabel();
    private let budgetLabel = UILabel();
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override func didMoveToSuperview() {
        self.parent = self.superview!;
        self.initalise();
    }
    
    func initalise() -> Void {
        backgroundColor = .cyan;
        translatesAutoresizingMaskIntoConstraints = false;
        widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.9).isActive = true;
        heightAnchor.constraint(equalToConstant: 150).isActive = true;
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true;
        topAnchor.constraint(equalTo: parent.topAnchor, constant: 20).isActive = true;
        layer.cornerRadius = 20;
        
        self.montlyBudgetTitleConstraints();
        self.budgetLabelConstraints();
    }
    
    private func montlyBudgetTitleConstraints() -> Void {
        addSubview(label);
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Montly Budget";
        label.textColor = .black;
        label.font = .systemFont(ofSize: 13, weight: .regular);
        label.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true;
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true;
    }
    
    private func budgetLabelConstraints() -> Void {
        addSubview(budgetLabel);
        
        budgetLabel.translatesAutoresizingMaskIntoConstraints = false;
        budgetLabel.text = "20,000";
        budgetLabel.textColor = .black;
        budgetLabel.font = .systemFont(ofSize: 35, weight: .bold);
        budgetLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true;
        budgetLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true;
    }
}

func AlertController(message: String) -> UIAlertController {
    let alertController = UIAlertController(title: "Attention", message: message, preferredStyle: .alert);
    
    let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        print("Ok button tapped");
    }
    alertController.addAction(OKAction);
    
    return alertController;
}

class TransactionView: UIView {
    private var parent = UIView();
    private let categoryName = UILabel();
    private let budgetLabel = UILabel();
    private let circle = UIView();
    private let icon = UILabel();
    private let categoryTotal = UILabel();
    private let amount = UILabel();
    
    required init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
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
        layer.cornerRadius = 20;
        backgroundColor = .green;
        addSubview(circle);
        addSubview(categoryName);
        addSubview(categoryTotal);
        addSubview(amount);
        
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
        circle.addSubview(icon);
        circle.backgroundColor = UIColor(hex: "#854efe");
        circle.layer.cornerRadius = 25;
        
        icon.text = ("\\ud83d\\ude1d").decode();
        icon.translatesAutoresizingMaskIntoConstraints = false;
        icon.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true;
        icon.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true;
        icon.font = UIFont.systemFont(ofSize: 30);
    }
    
    private func categoryNameConstraints() -> Void {
        categoryName.translatesAutoresizingMaskIntoConstraints = false;
        categoryName.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 15).isActive = true;
        categoryName.topAnchor.constraint(equalTo: circle.topAnchor, constant: 2).isActive = true;
        categoryName.text = "Sample Category";
        categoryName.font = .systemFont(ofSize: 18, weight: .bold);
        categoryName.textColor = .black;
    }
    
    private func categoryTotalConstraints() -> Void {
        categoryTotal.translatesAutoresizingMaskIntoConstraints = false;
        categoryTotal.leadingAnchor.constraint(equalTo: categoryName.leadingAnchor).isActive = true;
        categoryTotal.bottomAnchor.constraint(equalTo: circle.bottomAnchor, constant: -2).isActive = true;
        categoryTotal.text = "15% used from total";
        categoryTotal.font = .systemFont(ofSize: 13, weight: .regular);
        categoryTotal.textColor = .black;
    }
    
    private func amountLabelConstraints() -> Void {
        amount.translatesAutoresizingMaskIntoConstraints = false;
        amount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true;
        amount.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        amount.text = "₹45678";
        amount.font = .systemFont(ofSize: 18, weight: .semibold);
        amount.textColor = .black;
    }
}

