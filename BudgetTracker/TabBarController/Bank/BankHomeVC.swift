import UIKit;

class BankViewController: UIViewController {
    let addButton = AddButton();
    let scroller = UIScrollView();
    let stackView = UIStackView();
    var banks: [BankWithId] = [];
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .SystemBasedBg;
        
        view.addSubview(scroller);
        view.addSubview(addButton);
        
        scroller.addSubview(stackView);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);

        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 30;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
        
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        addButton.addTarget(self, action: #selector(navigateToInsertBankVC), for: .touchDown);
        
        fetchListOfBanks();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchListOfBanks();
    }
    
    private func fetchListOfBanks() -> Void {
        banks = BankServices.list();
        
        for bank in banks {
            let name = bank.name;
            let label = BankLabel(bank: name);
            stackView.addArrangedSubview(label);
        }
    }
    
    @objc private func navigateToInsertBankVC() -> Void {
        self.present(alertController(), animated: true, completion: nil);
    }
    
    private func alertController() -> UIAlertController {
        let alert = UIAlertController(title: "Add Bank", message: "Enter name of the bank", preferredStyle: .alert);
        
        alert.addTextField { textField in
            textField.text = "";
        }
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            let textField: UITextField = alert!.textFields![0];
                        
            if !textField.text!.isEmpty {
                let _ = BankServices.insert(bank: textField.text!);
            }
        }));
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel));
        
        return alert;
    }
}

class BankLabel: UILabel {
    var name: String;
    
    required init?(coder: NSCoder) {
        self.name = "";
        super.init(coder: coder);
    }
    
    required init(bank name: String) {
        self.name = name;
        super.init(frame: .zero);
    }
    
    override func didMoveToSuperview() {
        let parent: UIView = self.superview!;
        self.initalize(parent: parent);
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        textColor = .SystemBasedText;
    }
    
    private func initalize(parent view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false;
        text = self.name;
        textColor = .SystemBasedText;
        font = .systemFont(ofSize: 20, weight: .medium)
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
    }
}
