import UIKit;

class CategoryAddController: UIViewController {
    let circle = UIView();
    let textField = UITextField();
    let emojiField = UITextField();
    let descriptionField = UITextView();
    let button = UIButton();
    let colorPicker: UIColorWell =  {
        let picker = UIColorWell();
        picker.title = "Pick a color for Category";
        picker.selectedColor = .cyan;
        picker.supportsAlpha = true;
        
        return picker;
    }();
    
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
        colorPicker.backgroundColor = .green;
        colorPicker.layer.cornerRadius = 50;
        colorPicker.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        colorPicker.addTarget(self, action: #selector(colorChanged), for: .valueChanged)
        
        emojiField.translatesAutoresizingMaskIntoConstraints = false;
        emojiField.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20).isActive = true;
        emojiField.widthAnchor.constraint(equalToConstant: 50).isActive = true;
        emojiField.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        emojiField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        emojiField.layer.cornerRadius = 25;
        emojiField.backgroundColor = .green;
        emojiField.textAlignment = .center;
        emojiField.placeholder = "🏠";
        
        textField.translatesAutoresizingMaskIntoConstraints = false;
        textField.topAnchor.constraint(equalTo: emojiField.bottomAnchor, constant: 20).isActive = true;
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        textField.heightAnchor.constraint(equalToConstant: 55).isActive = true;
        textField.attributedPlaceholder = NSAttributedString(string: "Category name", attributes: [.font: UIFont.boldSystemFont(ofSize: 33.0)]);
        textField.font = .systemFont(ofSize: 33, weight: .semibold)
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false;
        descriptionField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true;
        descriptionField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        descriptionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        descriptionField.heightAnchor.constraint(equalToConstant: 100).isActive = true;
//        descriptionField.placeholder = "Category description";
        descriptionField.isScrollEnabled = false;
        descriptionField.textContainer.lineBreakMode = .byWordWrapping
        descriptionField.backgroundColor = .none;
        descriptionField.font = UIFont.systemFont(ofSize: 22)
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20).isActive = true;
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true;
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true;
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue;
        button.titleLabel?.textColor = .white;
        button.addTarget(self, action: #selector(submit), for: .touchUpInside);
    }
    
    @objc private func colorChanged() {
        colorPicker.backgroundColor = colorPicker.selectedColor;
        print("Selected color is: \(colorPicker.selectedColor!)");
    }
    
    @objc private func submit() {
        print("Category color: \(colorPicker.selectedColor!.toHexString())");
        print("Category name: \(textField.text!)");
        print("Category icon: \(emojiField.text!.decode())");
        print("Category description: \(descriptionField.text!)");
        
        let _: StatusCode = Categories.insert(payload: Category(
            name: textField.text!,
            description: descriptionField.text!,
            icon: emojiField.text!.encode(),
            color: colorPicker.selectedColor!.toHexString()
        ));
        
        self.dismiss(animated: true);
    }
}
