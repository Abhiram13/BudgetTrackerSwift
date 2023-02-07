import UIKit;

class CategoryHomeController: UIViewController {
    let scroller = UIScrollView();
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green;
        
        view.addSubview(scroller);
        
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.backgroundColor = .systemPink;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);
    }
}
