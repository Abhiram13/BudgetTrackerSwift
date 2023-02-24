import UIKit;
import SwiftUI;

class CategoryHomeController: UIViewController {
    let scroller = UIScrollView();
    let stackView = UIStackView();
    let label = UILabel();
    var categories: [CategoryWithId] = [];
    let refresh = UIRefreshControl();
    let button = AddButton();
    let noCategoriesLabel = UILabel();
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection);
        
        view.backgroundColor = .SystemBasedBg;
        noCategoriesLabel.textColor = .SystemBasedText
    }
    
    override func viewDidLoad() {
        view.addSubview(scroller);
        view.addSubview(label);
        view.addSubview(button);
        
        view.backgroundColor = .SystemBasedBg;
        
        scroller.addSubview(stackView);
        scroller.translatesAutoresizingMaskIntoConstraints = false;
        scroller.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true;
        scroller.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true;
        scroller.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true;
        scroller.contentSize = CGSize(width: view.frame.width, height: 2000);
        scroller.addSubview(noCategoriesLabel);
        
        noCategoriesLabel.translatesAutoresizingMaskIntoConstraints = false;
        noCategoriesLabel.centerXAnchor.constraint(equalTo: scroller.centerXAnchor).isActive = true;
        noCategoriesLabel.centerYAnchor.constraint(equalTo: scroller.centerYAnchor).isActive = true;
        noCategoriesLabel.font = .systemFont(ofSize: 35, weight: .medium);
        noCategoriesLabel.text = "No Categories";
        noCategoriesLabel.textColor = .SystemBasedText;
        
        stackView.axis = .vertical;
        stackView.alignment = .fill;
        stackView.spacing = 20;
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.topAnchor.constraint(equalTo: scroller.topAnchor).isActive = true;
        stackView.widthAnchor.constraint(equalTo: scroller.widthAnchor).isActive = true;
        
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true;
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true;
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addCategory)));
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        scroller.refreshControl = refresh;
        
        self.fetchListOfCategories {};
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Hello");
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
        
        if categories.count > 0 {
            noCategoriesLabel.removeFromSuperview();
        }
        
        for category in categories {
            self.addCatgeoryInStackAndAttachGesture(
                name: category.name,
                desc: category.description,
                emoji: category.icon,
                color: category.color,
                rowId: category.rowId
            );
        }
        
        refreshCategories();
    }
    
    private func addCatgeoryInStackAndAttachGesture(name: String, desc: String, emoji: String, color: String, rowId: String) -> Void {
        let gesture = CategoryGesture(target: self, action: #selector(editCategory));
        gesture.catName = name;
        gesture.desc = desc;
        gesture.emoji = emoji;
        gesture.color = color;
        gesture.rowId = rowId;
        
        let categoryView = CategoryView(name: name, color: color, emoji: emoji, description: desc);
        categoryView.addGestureRecognizer(gesture);
        
        stackView.addArrangedSubview(categoryView);
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
    
    @objc private func editCategory(sender: CategoryGesture) {
        self.modalPresentationStyle = .fullScreen;
        self.present(CategoryEditController(
            name: sender.catName!,
            desc: sender.desc!,
            emoji: sender.emoji!,
            color: UIColor(hex: sender.color!),
            rowId: sender.rowId!
        ), animated: true, completion: nil)
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

func AddButton() -> UIButton {
    let button = UIButton();
    let label = UILabel();
    
    button.addSubview(label);
    button.translatesAutoresizingMaskIntoConstraints = false;
    button.widthAnchor.constraint(equalToConstant: 70).isActive = true;
    button.heightAnchor.constraint(equalToConstant: 70).isActive = true;
    button.backgroundColor = .red;
    button.layer.cornerRadius = 35
    
    label.translatesAutoresizingMaskIntoConstraints = false;
    label.text = "+";
    label.textColor = .white;
    label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true;
    label.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: -2).isActive = true;
    label.font = .systemFont(ofSize: 40, weight: .medium);
    
    return button;
}

class CategoryGesture: UITapGestureRecognizer {
    var catName: String?;
    var desc: String?;
    var emoji: String?;
    var color: String?;
    var rowId: String?;
}
