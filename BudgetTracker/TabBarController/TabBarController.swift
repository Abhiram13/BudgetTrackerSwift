import Foundation;
import UIKit;

class TabBarController: UITabBarController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        self.tabBar.backgroundColor = .SystemBasedBg;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNC = UINavigationController(rootViewController: HomeViewController());
        let categoryNC = UINavigationController(rootViewController: CategoryHomeController());
        let bankNC = UINavigationController(rootViewController: BankViewController());
        let logVC = LogController();
                
        homeNC.title = "Home";
        categoryNC.title = "Categories";
        bankNC.title = "Banks";
        logVC.title = "Logs";
        
        self.tabBar.backgroundColor = .SystemBasedBg;
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor;
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.tintColor = .systemMint
        
        self.setViewControllers([homeNC, categoryNC, bankNC, logVC], animated: false);
        
        guard let tabs: [UITabBarItem] = self.tabBar.items else {return};
        let tabImages: [String] = ["house", "list.bullet", "dollarsign.arrow.circlepath", "terminal"];
        
        for i in 0..<tabs.count {
            let image = UIImage(systemName: tabImages[i]);
            tabs[i].image = image;
        }
    }
}
