import UIKit;

class BankViewController: UIViewController {
    let addButton = AddButton();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        view.addSubview(addButton);
        view.backgroundColor = .SystemBasedBg;
        
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        addButton.addTarget(self, action: #selector(navigateToInsertBankVC), for: .touchDown);
    }
    
    @objc private func navigateToInsertBankVC() -> Void {
        self.modalPresentationStyle = .fullScreen;
        self.present(InsertBankViewController(), animated: true, completion: nil);
    }
}
