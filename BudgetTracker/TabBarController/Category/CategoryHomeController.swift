import UIKit;

extension String {
    func decode() -> String {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
    
    func encode() -> String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
    }
}

class CategoryHomeController: UIViewController {
    let scroller = UIScrollView();
    let stackView = UIStackView();
    let label = UILabel();
    var categories: [CategoryWithId] = [];
    let refresh = UIRefreshControl();
    
    override func viewDidLoad() {
        view.addSubview(scroller);
        view.addSubview(label);
        
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
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        label.text = "Add Category";
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addCategory)));
        label.isUserInteractionEnabled = true;
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        scroller.refreshControl = refresh;
        
        self.fetchListOfCategories {};
    }
    
    @objc private func refreshed() {
        self.fetchListOfCategories {
            self.refresh.endRefreshing();
        }
    }
    
    private func fetchListOfCategories(refreshCategories: @escaping () -> Void) -> Void {
        categories = Categories.list();
        
        self.removeCategoriesFromStack();
        
        for category in categories {
            stackView.addArrangedSubview(CategoryView(
                name: category.name,
                color: category.color,
                emoji: category.icon,
                description: category.description
            ));
        }
        
        refreshCategories();
    }
    
    private func removeCategoriesFromStack() -> Void {
        stackView.subviews.forEach { categoryView in
            categoryView.removeFromSuperview();
        }
    }
    
    @objc private func addCategory() {
        self.modalPresentationStyle = .fullScreen;
        self.present(CategoryAddController(), animated: true, completion: nil);
    }
}

class CategoryView: UIView {
    var name: String = "";
    var color: String = "";
    var emoji: String = "";
    var info: String = "";
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!;
    }
    
    init(name: String, color: String, emoji: String, description: String) {
        super.init(frame: .zero);
        self.info = description;
        self.color = color;
        self.name = name;
        self.emoji = emoji;
    }
    
    override func didMoveToSuperview() {
        self.superview != nil ? self.initalise() : nil;
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
        
        circle.translatesAutoresizingMaskIntoConstraints = false;
        circle.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7).isActive = true;
        circle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        circle.addSubview(icon);
        circle.backgroundColor = UIColor(hex: self.color);
        circle.layer.cornerRadius = 25
        
//        icon.text = "😎";
        icon.text = self.emoji.decode();
        icon.translatesAutoresizingMaskIntoConstraints = false;
        icon.centerYAnchor.constraint(equalTo: circle.centerYAnchor).isActive = true;
        icon.centerXAnchor.constraint(equalTo: circle.centerXAnchor).isActive = true;
        icon.font = UIFont.systemFont(ofSize: 30);
        
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.text = self.name;
        label.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 20).isActive = true;
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true;
        label.font = .systemFont(ofSize: 20, weight: .medium);
    }
}
