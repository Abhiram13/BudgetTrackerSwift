import UIKit;

class BankViewController: UIViewController {
    let addButton = AddButton();
    let scroller = UIScrollView();
    let stackView = UIStackView();
    var banks: [BankWithId] = [];
    let noBanksLabel = UILabel();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .SystemBasedBg;
        
        view.addSubview(scroller);
        view.addSubview(addButton);
        
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        self.navigationItem.title = "Banks"
        
        scroller.addSubview(stackView);
        scroller.addSubview(noBanksLabel);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        scroller.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);

        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 50;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
        
        noBanksLabel.translatesAutoresizingMaskIntoConstraints = false;
        noBanksLabel.centerXAnchor.constraint(equalTo: scroller.centerXAnchor).isActive = true;
        noBanksLabel.centerYAnchor.constraint(equalTo: scroller.centerYAnchor).isActive = true;
        noBanksLabel.font = .systemFont(ofSize: 30, weight: .medium);
        noBanksLabel.text = "No Banks added";
        noBanksLabel.textColor = .SystemBasedText;
        
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        addButton.addTarget(self, action: #selector(navigateToInsertBankVC), for: .touchDown);
        
        fetchListOfBanks();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchListOfBanks();
    }
    
    private func postNotification() -> Void {
        NotificationCenter.default.post(name: Notification.Name("color.update"), object: nil, userInfo: ["colorUpdate": UIColor.green]);
    }
    
    private func fetchListOfBanks() -> Void {
        banks = BankServices.list();
        
        self.removeBankLabelsFromStack()
        
        if banks.count > 0 {
            noBanksLabel.removeFromSuperview();
        }
        
        for bank in banks {
            let name = bank.name;
            let label = BankLabel(bank: name);
            stackView.addArrangedSubview(label);
        }
    }
    
    private func removeBankLabelsFromStack() -> Void {
        stackView.subviews.forEach { bankLabels in
            bankLabels.removeFromSuperview();
        }
    }
    
    @objc private func navigateToInsertBankVC() -> Void {
        self.present(alertController(), animated: true, completion: nil);
        postNotification();
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

class BankLabel: UIView {
    var name: String;
    let label = UILabel();
    let image = UIImage(systemName: "dollarsign.arrow.circlepath");
    
    required init?(coder: NSCoder) {
        self.name = "";
        super.init(coder: coder);
    }
    
    required init(bank name: String) {
        self.name = name;
        super.init(frame: .zero);
    }
    
    override func didMoveToSuperview() {
        if self.superview != nil {
            let parent: UIView = self.superview!;
            self.initalize(parent: parent);
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        label.textColor = .SystemBasedText;
    }
    
    private func initalize(parent view: UIView) {
        let imageView = UIImageView(image: image);
        
        addSubview(label);
        addSubview(imageView);
        
        translatesAutoresizingMaskIntoConstraints = false;
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true;
        
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true;
        
        label.text = self.name;
        label.textColor = .SystemBasedText;
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true;
    }
}
