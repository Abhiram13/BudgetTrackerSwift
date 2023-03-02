import UIKit
import SwiftUI;

class HomeViewController: UIViewController {
    let reportView = ReportView();
    let addButton = AddButton();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = .SystemBasedBg;
        view.addSubview(reportView);
        view.addSubview(addButton);
        
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        addButton.addTarget(self, action: #selector(navigateToAddView), for: .touchDown)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let _ = Database();
        self.tabBarController?.tabBar.isHidden = false;
        
        let x = TransactionServices.list();
        
        print("THE LIST IS: \(x)");
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
        widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.8).isActive = true;
        heightAnchor.constraint(equalToConstant: 150).isActive = true;
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true;
        topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
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

