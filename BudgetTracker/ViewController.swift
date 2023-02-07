import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name("com.bt.alert"), object: nil, userInfo: ["name": "name"]);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(notify(_:)), name: Notification.Name("com.bt.alert"), object: nil);
    }
    
    @objc private func notify(_ notification: Notification) {
        let alert: UIAlertController = AlertController(message: notification.userInfo!["name"] as! String);
        
        self.present(alert, animated: true, completion: nil)
        print("This alert has been notified");
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

