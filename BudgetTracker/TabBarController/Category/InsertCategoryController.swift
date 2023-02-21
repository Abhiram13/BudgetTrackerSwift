import UIKit;

class CategoryAddController: UIViewController {
    let circle = UIView();
    let textField = UITextField();
    let emojiField = UITextField();
    let descriptionField = UITextView();
    let button = UIButton();
    
    var pickerColor: UIColor;
    var categoryName: String;
    var categoryDescription: String;
    var emoji: String;
    var rowId: String?;
    
    let colorPicker: UIColorWell =  {
        let picker = UIColorWell();
        picker.title = "Pick a color for Category";
        picker.selectedColor = .cyan;
        picker.supportsAlpha = true;
        
        return picker;
    }();
    
    required init?(coder: NSCoder) {
        self.pickerColor = .cyan;
        self.categoryName = "";
        self.categoryDescription = "";
        self.emoji = "😝";
        self.rowId = nil;
        super.init(coder: coder);
    }
    
    init() {
        self.pickerColor = .cyan;
        self.categoryName = "";
        self.categoryDescription = "";
        self.emoji = "😝";
        self.rowId = nil;
        super.init(nibName: nil, bundle: nil);
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .SystemBasedBg;
        view.addSubview(colorPicker);
        view.addSubview(emojiField);
        view.addSubview(textField);
        view.addSubview(descriptionField);
        view.addSubview(button);
        
        colorPicker.translatesAutoresizingMaskIntoConstraints = false;
        colorPicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true;
        colorPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true;
        colorPicker.layer.cornerRadius = 50;
        colorPicker.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorPicker.addTarget(self, action: #selector(colorChanged), for: .valueChanged);
        colorPicker.selectedColor = self.pickerColor;
        
        emojiField.translatesAutoresizingMaskIntoConstraints = false;
        emojiField.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20).isActive = true;
        emojiField.widthAnchor.constraint(equalToConstant: 70).isActive = true;
        emojiField.heightAnchor.constraint(equalToConstant: 70).isActive = true;
        emojiField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        emojiField.layer.cornerRadius = 35;
        emojiField.backgroundColor = colorPicker.selectedColor;
        emojiField.textAlignment = .center;
        emojiField.text = self.emoji.decode();
        
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.topAnchor.constraint(equalTo: emojiField.bottomAnchor, constant: 20).isActive = true;
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        textField.heightAnchor.constraint(equalToConstant: 55).isActive = true;
        textField.attributedPlaceholder = NSAttributedString(string: "Category name", attributes: [.font: UIFont.boldSystemFont(ofSize: 33.0)]);
        textField.font = .systemFont(ofSize: 33, weight: .semibold)
        textField.textAlignment = .center;
        textField.text = self.categoryName;
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false;
        descriptionField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true;
        descriptionField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        descriptionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        descriptionField.heightAnchor.constraint(equalToConstant: 100).isActive = true;
        descriptionField.isScrollEnabled = false;
        descriptionField.textContainer.lineBreakMode = .byWordWrapping
        descriptionField.backgroundColor = .none;
        descriptionField.font = UIFont.systemFont(ofSize: 22);
        descriptionField.text = self.categoryDescription;
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20).isActive = true;
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true;
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue;
        button.titleLabel?.textColor = .white;
        button.layer.cornerRadius = 10;
        button.addTarget(self, action: #selector(submit), for: .touchUpInside);
    }
    
    @objc private func colorChanged() {
        colorPicker.backgroundColor = colorPicker.selectedColor;
        emojiField.backgroundColor = colorPicker.selectedColor;
        print("Selected color is: \(colorPicker.selectedColor!)");
    }
    
    @objc private func submit() {
        print("Category color: \(colorPicker.selectedColor!.toHexString())");
        print("Category name: \(textField.text!)");
        print("Category icon: \(emojiField.text!.decode())");
        print("Category description: \(descriptionField.text!)");
        
        rowId == nil ? self.insert() : self.update();
        
        self.dismiss(animated: true);
    }
    
    private func insert() {
        let _: StatusCode = Categories.insert(payload: Category(
            name: textField.text!,
            description: descriptionField.text!,
            icon: emojiField.text!.encode(),
            color: colorPicker.selectedColor!.toHexString()
        ));
    }
    
    private func update() {
        let _: StatusCode = Categories.update(payload: CategoryWithId(
            id: 0,
            rowId: rowId!,
            name: textField.text!,
            description: descriptionField.text!,
            icon: emojiField.text!.encode(),
            color: colorPicker.selectedColor!.toHexString()
        ));
    }
}

class CategoryEditController: CategoryAddController {
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    init(name: String, desc: String, emoji: String, color: UIColor, rowId: String) {
        super.init();
        self.categoryName = name;
        self.categoryDescription = desc;
        self.emoji = emoji;
        self.pickerColor = color;
        self.rowId = rowId;
    }
}
