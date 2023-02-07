import Foundation;
import UIKit;

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController());
        
        // set title for view controllers
        homeViewController.title = "Home";
        
        self.tabBar.backgroundColor = .white;
        self.tabBar.layer.shadowColor = UIColor.gray.cgColor;
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.tabBar.layer.shadowRadius = 5
        
        self.setViewControllers([homeViewController], animated: false);
    }
}
