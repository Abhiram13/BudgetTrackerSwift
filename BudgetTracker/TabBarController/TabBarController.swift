import Foundation;
import UIKit;

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeNC = UINavigationController(rootViewController: HomeViewController());
        let categoryNC = UINavigationController(rootViewController: CategoryHomeController());
        let logVC = LogController();
                
        homeNC.title = "Home";
        categoryNC.title = "Categories";
        logVC.title = "Logs";
        
        self.tabBar.backgroundColor = .white;
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor;
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.tabBar.layer.shadowRadius = 5
        
        self.setViewControllers([homeNC, categoryNC, logVC], animated: false);
    }
}
