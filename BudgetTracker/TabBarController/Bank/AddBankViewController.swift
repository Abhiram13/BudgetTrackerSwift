import UIKit;

class InsertBankViewController: UIViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .SystemBasedBg;
    }
}
