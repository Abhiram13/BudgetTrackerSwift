import UIKit;

class CategoryHomeController: UIViewController {
    let scroller = UIScrollView();
    let stackView = UIStackView();
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green;
        
        view.addSubview(scroller);
        
        scroller.addSubview(stackView);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);
        
        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 20;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
        
        for _ in 0..<5 {
            stackView.addArrangedSubview(CategoryView());
        }
    }
}

class CategoryView: UIView {
    override func didMoveToSuperview() {
        self.initalise();
    }
    
    private func initalise() {
        let parent = self.superview!;
        let label = UILabel();
        let icon = UILabel();
        let circle = UIView();
        
        addSubview(circle);
        addSubview(label);
        
        translatesAutoresizingMaskIntoConstraints = false;
        widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.9).isActive = true;
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true;
        heightAnchor.constraint(equalToConstant: 60).isActive = true;
        layer.cornerRadius = 10;
//        backgroundColor = .cyan;
        
        circle.translatesAutoresizingMaskIntoConstraints = false;
        circle.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true;
        circle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        circle.addSubview(icon);
        circle.backgroundColor = .red;
        circle.layer.cornerRadius = 25
        
        icon.text = "😎";
        icon.translatesAutoresizingMaskIntoConstraints = false;
        icon.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true;
        icon.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true;
        icon.font = UIFont.systemFont(ofSize: 30);
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = "Sample category";
        label.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 20).isActive = true;
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        label.font = .systemFont(ofSize: 20, weight: .medium);
    }
}
